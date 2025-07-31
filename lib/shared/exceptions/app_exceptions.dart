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

class ServerException extends AppException {
  ServerException(String message) : super(message, 'SERVER_ERROR');
}
