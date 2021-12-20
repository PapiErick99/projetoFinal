import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  String label = "";
  String hint = "";
  bool pass;
  TextEditingController txtCampo = TextEditingController();
  TextInput(this.label, this.hint, this.pass, this.txtCampo, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: txtCampo,
        obscureText: pass,
        decoration: InputDecoration(label: Text(label), hintText: hint),
      ),
    );
  }
}
