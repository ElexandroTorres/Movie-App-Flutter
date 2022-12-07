import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/login/view/widgets/login_input.dart';
import 'package:movie_app/app/login/viewmodel/login_viewmodel.dart';
import 'package:movie_app/app/movie/view/pages/top_rated_page.dart';
import 'package:movie_app/app/utils/constants.dart';
import 'package:movie_app/app/utils/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _userName;
  String? _userPassword;

  late final LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    _loginViewModel.addListener(() {
      if (_loginViewModel.loginStatus == LoginStatus.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TopRatedPage(),
          ),
        );
      }
      if (_loginViewModel.loginStatus == LoginStatus.internetError ||
          _loginViewModel.loginStatus == LoginStatus.loginError) {
        _loginError(_loginViewModel.loginStatus);
      }
    });
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não possivel abrir a pagina de cadastro.'),
      ));
    }
  }

  void _loginError(LoginStatus loginStatus) {
    String message = '';
    if (loginStatus == LoginStatus.internetError) {
      message = 'Erro ao tentar logar. Cheque a sua conexão.';
    } else if (loginStatus == LoginStatus.loginError) {
      message = 'Usuario e/ou Senha invalidos';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Best Movies',
                  style: AppTheme.textStyles.appNameTitle,
                ),
                const SizedBox(height: 32.0),
                LoginInput(
                  prefixIcon: Icons.person,
                  hintText: 'Digite o nome de usuario',
                  labelText: 'Usuario',
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Informe o seu usuario';
                    }
                    return null;
                  }),
                  onSaved: ((newValue) {
                    _userName = newValue!;
                  }),
                ),
                const SizedBox(height: 16.0),
                LoginInput(
                  prefixIcon: Icons.lock,
                  isObscure: true,
                  hintText: 'Digite a sua senha',
                  labelText: 'Senha',
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Informe a sua senha';
                    }
                    return null;
                  }),
                  onSaved: ((newValue) {
                    _userPassword = newValue!;
                  }),
                ),
                const SizedBox(height: 8.0),
                Consumer<LoginViewModel>(
                  builder: (context, loginViewModel, _) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        textStyle: AppTheme.textStyles.loginButtonText,
                        primary: AppTheme.colors.primary,
                      ),
                      onPressed: loginViewModel.loginStatus ==
                              LoginStatus.loading
                          ? null
                          : () {
                              bool isValid = _formKey.currentState!.validate();
                              if (!isValid) {
                                return;
                              }
                              _formKey.currentState!.save();

                              loginViewModel.login(_userName!, _userPassword!);
                            },
                      child: const Text('Entrar'),
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                RichText(
                  text: TextSpan(
                    text: 'Não tem uma conta? ',
                    style: AppTheme.textStyles.signupText,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Cadastrar',
                        style: AppTheme.textStyles.signupLink,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            _launchInWebViewOrVC(
                              Uri.parse(tmdbSignup),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}