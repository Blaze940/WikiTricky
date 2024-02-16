import 'package:wiki_tricky/src/models/error/api_error.dart';

class AuthApiException extends ApiError {
  AuthApiException(
      {required int code, required String message,  payload = const {}})
      : super(code: code, message: message, payload: payload);
}
