class LoginErrorException implements Exception {
  String cause;
  LoginErrorException(this.cause);
}
