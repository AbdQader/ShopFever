class AppException implements Exception {
  late String? message;
  late String? prefix;
  late String? url;

  AppException({
    this.message,
  });
}

//invalid params
class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message: message);
}

//invalid url
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message: message);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message])
      : super(message: message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message: message,);
}

class NotFoundException extends AppException {
  NotFoundException([String? message])
      : super(message: message);
}
