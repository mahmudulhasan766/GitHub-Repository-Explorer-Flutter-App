import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:readback/core/extensions/string_extensions.dart';

import '../../core/app/app_dependency.dart';
import '../../core/components/custom_progress_loader.dart';
import '../../core/typedef/typedef.dart';
import 'api_client.dart';
import 'api_exception.dart';
import 'api_failure.dart';
import 'app_error.dart';
import 'http_method.dart';

@injectable
class ApiRequest {
  final ApiClient? apiClient = instance.get();

  Future<Either<ApiFailure, T>> performRequest<T>({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? params,
    Function? fromJson,
    bool isMultipart = false,
    ProgressCallback? onSendProgress, // Added callback for upload progress
    ProgressCallback? onReceiveProgress,
    int? id,
  }) async {
    try {
      final response = await apiClient?.request(
          url: id != null ? '$url/$id' : url,
          method: method,
          params: params,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          formData: isMultipart ? FormData.fromMap(params ?? {}) : null,
          isMultipart: isMultipart);

      if (fromJson != null) {
        return Right(fromJson(response));
      } else {
        return Right(response);
      }
    } catch (error, stackTrace) {
      dismissProgressDialog();
      logError(error, stackTrace, url, params ?? {});
      return Left(ApiException.handle(error).failure);
    }
  }

  void logError(dynamic error, dynamic stackTrace, String url, Params params) {
    AppError().allAppError(
      message: "$error\n$stackTrace",
      requestParams: url.requestParams(params),
    );

    log('Error on $url: $error\nStack Trace: $stackTrace');
  }
}
