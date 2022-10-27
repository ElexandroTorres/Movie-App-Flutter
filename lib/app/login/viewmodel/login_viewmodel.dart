import 'package:flutter/foundation.dart';
import 'package:movie_app_flutter/app/login/model/token_request.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';
import 'package:movie_app_flutter/app/utils/exceptions.dart';

enum LoginStatus { loggedOut, loading, success, loginError, internetError }

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository;
  late TokenRequest _tokenRequest;

  LoginStatus _loginStatus = LoginStatus.loggedOut;
  LoginStatus get loginStatus => _loginStatus;

  LoginViewModel(this._loginRepository);

  Future<void> login(String userName, String password) async {
    try {
      _loginStatus = LoginStatus.loading;
      notifyListeners();
      _tokenRequest = await _loginRepository.getTokenRequest();

      if (_tokenRequest.success!) {
        _tokenRequest = await _loginRepository.login(
            userName, password, _tokenRequest.requestToken!);
        _loginStatus = LoginStatus.success;
        notifyListeners();
      }
    } on LoginErrorException {
      _loginStatus = LoginStatus.loginError;
      notifyListeners();
    } catch (error) {
      _loginStatus = LoginStatus.internetError;
      notifyListeners();
    }
  }
}
