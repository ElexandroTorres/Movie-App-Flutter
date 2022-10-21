import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _userName;
  String? _userPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Digite algo';
                  }
                  return null;
                }),
                onSaved: ((newValue) {
                  _userName = newValue!;
                }),
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Digite o nome de usuario',
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.yellow,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.yellow,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Informe a sua senha';
                  }
                  return null;
                }),
                onSaved: ((newValue) {
                  _userPassword = newValue!;
                }),
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Digite a sua senha',
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.yellow,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.yellow,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: provider.loginStatus == LoginStatus.loading
                    ? null
                    : () {
                        bool isValid = _formKey.currentState!.validate();
                        if (!isValid) {
                          return;
                        }

                        _formKey.currentState!.save();

                        provider.login(_userName!, _userPassword!);
                      },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
