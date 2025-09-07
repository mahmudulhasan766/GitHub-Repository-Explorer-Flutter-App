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
  final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();

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
            return;
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
        onError: (err, handler) {
          log('Status Code: ${err.response?.statusCode} Error Data: ${err.response?.data}');
          handler.next(err);
        },
      ),
    );
    //_dio.interceptors.add(PrettyDioLogger());
  }

  // Future<void> _retryRequest(
  //   RequestOptions options,
  //   RequestInterceptorHandler handler,
  // ) async {
  //   final headers = await _buildHeaders();
  //   options.headers.addAll(headers);
  //   try {
  //     final response = await _dio.request(
  //       options.path,
  //       options: Options(
  //         method: options.method,
  //         headers: options.headers,
  //         contentType: options.contentType,
  //         responseType: options.responseType,
  //         extra: options.extra,
  //         followRedirects: options.followRedirects,
  //         listFormat: options.listFormat,
  //         maxRedirects: options.maxRedirects,
  //         receiveDataWhenStatusError: options.receiveDataWhenStatusError,
  //         receiveTimeout: options.receiveTimeout,
  //         requestEncoder: options.requestEncoder,
  //         responseDecoder: options.responseDecoder,
  //         sendTimeout: options.sendTimeout,
  //         validateStatus: options.validateStatus,
  //       ),
  //       data: options.data,
  //       queryParameters: options.queryParameters,
  //       onSendProgress: options.onSendProgress,
  //       onReceiveProgress: options.onReceiveProgress,
  //     );
  //     handler.resolve(response);
  //   } on DioException catch (e) {
  //     handler.reject(e);
  //     rethrow;
  //   }
  // }

  Future<Map<String, dynamic>> _buildHeaders() async {
    final headers = {
      contentType: applicationJson,
      accept: applicationJson,
      active: 'true',
      language: "en",
    };
    //const accessToken = "97|Fu0sK7hvL8uw1mxxoZA0cuAhivfREqtz6TyfM9Qp813a2877";
    var accessToken = await _appPreferences.getUserToken();
    if (accessToken.isNotEmpty) {
      headers[authorization] = "Bearer $accessToken";
      log("Access token: $accessToken");
    }

    return headers;
  }

  Future<dynamic> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? params,
    FormData? formData,
    bool isMultipart = false,
    ProgressCallback? onSendProgress, // Added callback for upload progress
    ProgressCallback? onReceiveProgress, // Added callback for download progress
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

      // log('[$url] [${response.statusCode}] Response data: ${response.data}');
      return response.data;
    } on DioException catch (error) {
      log('DioError: $error');
      rethrow;
    } catch (error) {
      log('Error: $error');
      rethrow;
    }
  }

/* void _showNoInternetDialog(VoidCallback retryCallback) {
    // Close any previously opened dialogs
    if (_isDialogShowing) {
      Navigator.of(GetContext.context).popUntil((route) => route.isFirst);
    }

    _isDialogShowing = true;
    CustomDialog.errorDialog(
        context: GetContext.context,
        title: AppStrings.noConnection.tr(),
        details: AppStrings.noInternetMessage.tr(),
        confirmText: AppStrings.tryAgain.tr(),
        onYes: () {
          Navigator.of(GetContext.context).pop();
          _isDialogShowing = false;
          retryCallback();
        });
  }*/
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
      final response =
          await http.get(Uri.parse(testUrl)).timeout(Duration(seconds: 10));
      return response.statusCode == 200;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
  }
}
