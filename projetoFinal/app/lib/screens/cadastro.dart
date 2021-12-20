import 'dart:convert';

import 'package:app/api.dart';
import 'package:app/components/text_input.dart';
import 'package:app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  void newUser() async {
    var resp = await API.newAccount(txtNome.text, txtEmail.text, txtSenha.text);
    if (resp.statusCode == 201) {
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
          title: const Text("Cadastro"),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            TextInput("Nome", "fulano", false, txtNome),
            TextInput("Email", "fulano@gmail.com", false, txtEmail),
            TextInput("Senha", "*****", true, txtSenha),
            ElevatedButton(
              onPressed: newUser,
              child: const Text("Criar conta"),
            )
          ],
        ),
      ),
    );
  }
}
