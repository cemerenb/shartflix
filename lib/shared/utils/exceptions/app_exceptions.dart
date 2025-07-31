class AppException implements Exception {
  final String message;
  final String code;

  AppException(this.message, this.code);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message, 'NETWORK_ERROR');
}

class UnauthorizedException extends AppException {
  UnauthorizedException() : super('Yetkisiz erişim', 'UNAUTHORIZED');
}

class UserAlreadyExistsException extends AppException {
  UserAlreadyExistsException()
    : super('Kullanıcı zaten mevcut', 'USER_ALREADY_EXISTS');
}

class ServerException extends AppException {
  ServerException(String message) : super(message, 'SERVER_ERROR');
}
