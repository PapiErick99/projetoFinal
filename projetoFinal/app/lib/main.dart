import 'package:app/screens/home.dart';
import 'package:app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _inicializacao,
        builder: (context, app) {
          if (app.connectionState == ConnectionState.done) {
            return const Home();
          }

          return Login();
        },
      ),
    );
  }
}
