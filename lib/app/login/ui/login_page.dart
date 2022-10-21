import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _userEmail;
  String? _userPassword;

  @override
  Widget build(BuildContext context) {
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
                  _userEmail = newValue!;
                }),
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Digite o seu email',
                  labelText: 'Email',
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
                keyboardType: TextInputType.emailAddress,
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
                onPressed: () {
                  var valido = _formKey.currentState!.validate();
                  if (!valido) {
                    return;
                  }

                  _formKey.currentState!.save();
                  print('email: ${_userEmail}');
                  print('senha: ${_userPassword}');
                },
                child: Text('Me aperte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
