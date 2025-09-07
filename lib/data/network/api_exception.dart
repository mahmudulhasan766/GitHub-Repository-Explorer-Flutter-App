import 'package:dio/dio.dart';

import '../../core/constants/app_strings.dart';
import 'api_failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ApiException implements Exception {
  late ApiFailure failure;

  ApiException.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its error from response of the API
      String message = error.response?.data?['message'] ?? '';
      failure = _handleError(error, message);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure(error);
    }
  }

  ApiFailure _handleError(DioException error, String apiError) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure(apiError);
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure(apiError);
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure(apiError);
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure(apiError);
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure(apiError);
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure(apiError);
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure(apiError);
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure(apiError);
          default:
            return _getResponseError(error);
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure(apiError);
      default:
        return DataSource.defaultError.getFailure(apiError);
    }
  }

  ApiFailure _getResponseError(DioException error) {
    late String message;
    try {
      int code = error.response?.statusCode ?? 0;
      message = error.response?.data?['message'] ?? '';
      Map errorMessage = error.response?.data ?? {};
      return ApiFailure(code, message, errorMessage, message);
    } on Exception {
      return DataSource.defaultError.getFailure(message);
    }
  }
}

extension DataSourceExtension on DataSource {
  ApiFailure getFailure(String apiError) {
    switch (this) {
      case DataSource.badRequest:
        return ApiFailure(ResponseCode.badRequest, ResponseMessage.badRequest,
            ResponseMessage.badRequest, apiError);
      case DataSource.forbidden:
        return ApiFailure(ResponseCode.forbidden, ResponseMessage.forbidden,
            ResponseMessage.forbidden, apiError);
      case DataSource.unauthorized:
        return ApiFailure(
            ResponseCode.unauthorized,
            ResponseMessage.unauthorized,
            ResponseMessage.unauthorized,
            apiError);
      case DataSource.notFound:
        return ApiFailure(ResponseCode.notFound, ResponseMessage.notFound,
            ResponseMessage.notFound, apiError);
      case DataSource.internalServerError:
        return ApiFailure(
            ResponseCode.internalServerError,
            ResponseMessage.internalServerError,
            ResponseMessage.internalServerError,
            apiError);
      case DataSource.connectTimeout:
        return ApiFailure(
            ResponseCode.connectTimeout,
            ResponseMessage.connectTimeout,
            ResponseMessage.connectTimeout,
            apiError);
      case DataSource.cancel:
        return ApiFailure(ResponseCode.cancel, ResponseMessage.cancel,
            ResponseMessage.cancel, apiError);
      case DataSource.receiveTimeout:
        return ApiFailure(
            ResponseCode.receiveTimeout,
            ResponseMessage.receiveTimeout,
            ResponseMessage.receiveTimeout,
            apiError);
      case DataSource.sendTimeout:
        return ApiFailure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout,
            ResponseMessage.sendTimeout, apiError);
      case DataSource.cacheError:
        return ApiFailure(ResponseCode.cacheError, ResponseMessage.cacheError,
            ResponseMessage.cacheError, apiError);
      case DataSource.noInternetConnection:
        return ApiFailure(
            ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection,
            ResponseMessage.noInternetConnection,
            apiError);
      case DataSource.defaultError:
        return ApiFailure(
            ResponseCode.defaultError,
            ResponseMessage.defaultError,
            ResponseMessage.defaultError,
            apiError);
      default:
        return ApiFailure(
            ResponseCode.defaultError,
            ResponseMessage.defaultError,
            ResponseMessage.defaultError,
            apiError);
    }
  }
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorized = 401; // failure user is not unauthorized
  static const int notFound =
      404; // failure, api url is not correct and not found
  static const int authFailed =
      422; // failure, api url is not correct and not found
  static const int internalServerError =
      500; // failure, crash happened in server side

  // local status code
  static const int defaultError = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  // API response codes
  //static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.noContent; // success with no content
  static const String badRequest =
      AppStrings.badRequestError; // failure, api rejected our request
  static const String forbidden =
      AppStrings.forbiddenError; // failure,  api rejected our request
  static const String unauthorized =
      AppStrings.unauthorizedError; // failure, user is not authorized
  static const String notFound = AppStrings
      .notFoundError; // failure, API url is not correct and not found in api side.
  static const String internalServerError =
      AppStrings.internalServerError; // failure, a crash happened in API side.

  // local responses codes
  static const String defaultError =
      AppStrings.defaultError; // unknown error happened
  static const String connectTimeout =
      AppStrings.timeoutError; // issue in connectivity
  static const String cancel =
      AppStrings.defaultError; // API request was cancelled
  static const String receiveTimeout =
      AppStrings.timeoutError; //  issue in connectivity
  static const String sendTimeout =
      AppStrings.timeoutError; //  issue in connectivity
  static const String cacheError = AppStrings
      .defaultError; //  issue in getting data from local data source (cache)
  static const String noInternetConnection =
      AppStrings.noInternetMessage; // issue in connectivity
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
