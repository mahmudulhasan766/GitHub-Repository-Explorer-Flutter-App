import 'api_exception.dart';

class ApiFailure {
  int code; // 200 or 400
  String message; // error or success
  dynamic error; // error response
  String apiErrorMsg; // error response

  ApiFailure(this.code, this.message, this.error, this.apiErrorMsg);
}

class DefaultFailure extends ApiFailure {
  DefaultFailure()
      : super(
          ResponseCode.defaultError,
          ResponseMessage.defaultError,
          ResponseMessage.defaultError,
          ResponseMessage.defaultError,
        );
}
