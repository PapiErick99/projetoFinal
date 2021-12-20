import 'dart:convert';

import 'package:app/api.dart';
import 'package:app/components/text_input.dart';
import 'package:app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  void logar() async {
    var resp = await API.login(txtEmail.text, txtSenha.text);
    if (resp.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", jsonDecode(resp.body));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: [
        TextInput("Email", "fulano@gmail.com", false, txtEmail),
        TextInput("Senha", "*****", true, txtSenha),
        ElevatedButton(child: const Text("Entrar"), onPressed: logar)
      ]),
    ));
  }
}
