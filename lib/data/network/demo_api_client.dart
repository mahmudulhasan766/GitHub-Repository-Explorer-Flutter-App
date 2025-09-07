import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../core/app/app_dependency.dart';
import '../../core/app/app_preference.dart';
import 'api_urls.dart';
import 'http_method.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "Accept";
const String authorization = "Authorization";
const String platform = "App-Platform";
const String appVersion = "App-Version";
const String language = "language";
const String active = "active";
String platformStatus = Platform.isAndroid ? "android" : 'ios';

@Injectable()
class ApiClient {
  final AppPreferences _appPreferences;
  final Dio _dio;
  final InternetConnectionChecker _internetConnectionChecker = InternetConnectionChecker();

  bool _isRefreshing = false;
  // final List<Function()> _retryQueue = [];

  ApiClient(this._dio) : _appPreferences = instance.get<AppPreferences>() {
    initInterceptors();
  }

  void initInterceptors() {
    _dio.options.baseUrl = ApiUrls.baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!await _internetConnectionChecker.hasInternetConnection()) {
            log("No internet connection available.");
            return handler.reject(DioException(
              requestOptions: options,
              error: 'No internet connection',
              type: DioExceptionType.connectionError,
            ));
          }

          final headers = await _buildHeaders();
          options.headers.addAll(headers);

          log('Request headers ======> ${options.headers}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response received: ${response.statusCode}');
          handler.next(response);
        },
        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;

          // Token expired
          if (statusCode == 401 && !_isRefreshing) {
            _isRefreshing = true;

            final requestOptions = error.requestOptions;
            log("Access token expired. Attempting refresh...");

            final refreshed = await _refreshToken();
            _isRefreshing = false;

            if (refreshed) {
              final newAccessToken = await _appPreferences.getUserToken();
              requestOptions.headers[authorization] = "Bearer $newAccessToken";

              try {
                final retryResponse = await _dio.fetch(requestOptions);
                return handler.resolve(retryResponse);
              } catch (e) {
                return handler.reject(e as DioException);
              }
            } else {
              // Refresh failed — force logout
              // await _appPreferences.clearUserData(); // Add this in AppPreferences
              // Redirect to login (optional)
              log("Refresh failed. User logged out.");
              return handler.reject(error);
            }
          }

          log('Status Code: $statusCode Error Data: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _buildHeaders() async {
    final headers = {
      contentType: applicationJson,
      accept: applicationJson,
      active: 'true',
      language: "en",
    };

    final accessToken = await _appPreferences.getUserToken();
    if (accessToken.isNotEmpty) {
      headers[authorization] = "Bearer $accessToken";
      log("Access token: $accessToken");
    }

    return headers;
  }

  Future<bool> _refreshToken() async {
    /* final refreshToken = await _appPreferences.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      log("No refresh token available.");
      return false;
    }
*/
    try {
      /*  final response = await _dio.post(ApiUrls.refreshToken, data: {
        "refresh_token": refreshToken,
      });

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      if (newAccessToken != null && newRefreshToken != null) {
        await _appPreferences.setUserToken(newAccessToken);
        await _appPreferences.setRefreshToken(newRefreshToken);
        log("Token refreshed successfully.");
        return true;
      }*/
    } catch (e) {
      log("Token refresh failed: $e");
    }

    return false;
  }

  Future<dynamic> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? params,
    FormData? formData,
    bool isMultipart = false,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    log('[${method.name.toUpperCase()}${isMultipart ? '-MULTIPART' : ''}] Request url ======> ${_dio.options.baseUrl}$url');
    log('Request params ======> ${isMultipart ? (formData!.fields.toString() + formData.files.toString()) : params}');

    try {
      Response response;
      switch (method) {
        case HttpMethod.post:
          response = isMultipart && formData != null
              ? await _dio.post(url,
              data: formData,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
              : await _dio.post(url,
              data: params,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress);
          break;
        case HttpMethod.delete:
          response = await _dio.delete(url);
          break;
        case HttpMethod.put:
          response = isMultipart && formData != null
              ? await _dio.put(url,
              data: formData,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
              : await _dio.put(url,
              data: params,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress);
          break;
        case HttpMethod.get:
          response = await _dio.get(url,
              queryParameters: params, onReceiveProgress: onReceiveProgress);
          break;
        default:
          throw UnsupportedError("Unsupported HTTP method");
      }

      return response.data;
    } on DioException catch (error) {
      log('DioError: $error');
      rethrow;
    } catch (error) {
      log('Error: $error');
      rethrow;
    }
  }
}

class InternetConnectionChecker {
  final String testUrl = 'https://www.google.com';

  Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      return await _checkInternetAccess();
    }
    return false;
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final response = await http.get(Uri.parse(testUrl)).timeout(Duration(seconds: 10));
      return response.statusCode == 200;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
  }
}
