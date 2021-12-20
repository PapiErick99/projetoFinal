import 'package:app/screens/cadastro.dart';
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            width: 300,
            height: 300,
            child: Image(
              image: NetworkImage(
                  "https://149448277.v2.pressablecdn.com/wp-content/uploads/2017/07/compre-logo.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: const Text("Entrar"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Cadastro(),
                  ),
                );
              },
              child: const Text("Criar conta"),
            ),
          ),
        ],
      ),
    );
  }
}
