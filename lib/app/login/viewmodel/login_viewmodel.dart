import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/login/model/token_request.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';

enum LoginStatus { loggedOut, loading, success, loginError, internetError }

class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepository = LoginRepository();
  LoginStatus loginStatus = LoginStatus.loggedOut;
  late TokenRequest tokenRequest;

  Future<void> login(String userName, String password) async {
    try {
      loginStatus = LoginStatus.loading;
      notifyListeners();
      tokenRequest = await loginRepository.getTokenRequest();
      if (tokenRequest.success!) {
        tokenRequest = await loginRepository.login(userName, password);
        loginStatus = LoginStatus.success;
        notifyListeners();
      }
    } on NoInternetException catch (_) {
      loginStatus = LoginStatus.internetError;
      notifyListeners();
    } on FailToLoginException catch (_) {
      loginStatus = LoginStatus.loginError;
      notifyListeners();
    }
  }
}
