import 'package:app/api.dart';
import 'package:app/components/text_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({Key? key}) : super(key: key);

  @override
  _NewProductState createState() => _NewProductState();
}

enum Categories { carro, moto, pecaMoto, pecaCarro }

class _NewProductState extends State<NewProduct> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtQuantity = TextEditingController();
  Categories? _character = Categories.carro;
  void novoProduto() async {
    String categoria = "";
    if (_character == Categories.carro) {
      categoria = "61bf7a3282645762a1d5bb20";
    } else if (_character == Categories.moto) {
      categoria = "61bf7a4182645762a1d5bb21";
    } else if (_character == Categories.pecaCarro) {
      categoria = "61bf7a5e82645762a1d5bb23";
    } else {
      categoria = "61bf7aab82645762a1d5bb24";
    }
    var resp = await API.newProduct(txtName.text, int.parse(txtQuantity.text),
        categoria, int.parse(txtPrice.text));
    if (resp.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("productId", resp.body);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Novo produto"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Column(
        children: [
          const Text("Selecione a categoria"),
          ListTile(
            title: const Text('Carro'),
            leading: Radio<Categories>(
              value: Categories.carro,
              groupValue: _character,
              onChanged: (Categories? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Moto'),
            leading: Radio<Categories>(
              value: Categories.moto,
              groupValue: _character,
              onChanged: (Categories? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Peça de moto'),
            leading: Radio<Categories>(
              value: Categories.pecaMoto,
              groupValue: _character,
              onChanged: (Categories? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Peça de carro'),
            leading: Radio<Categories>(
              value: Categories.pecaCarro,
              groupValue: _character,
              onChanged: (Categories? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          TextInput("Nome do produto", "Bicicleta", false, txtName),
          TextInput("Preço do produto", "0.00", false, txtPrice),
          TextInput('Quantidade do produto', "1", false, txtQuantity),
          ElevatedButton(
              onPressed: () {
                novoProduto();
              },
              child: const Text("Enviar"))
        ],
      ),
    ));
  }
}
