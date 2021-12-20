import 'dart:convert';

import 'package:app/api.dart';
import 'package:app/class/item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({Key? key}) : super(key: key);

  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  List<Item> listaI = List<Item>.empty();
  _CarrinhoState() {
    items();
  }
  void items() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userId");
    var resp = await API.getItems(id);
    setState(() {
      Iterable aux = json.decode(resp.body);
      listaI = aux.map((json) => Item.fromJson(json)).toList();
    });
  }
//Finaliza compra, remove os itens assim que finalizar.
  void finalizarCompra() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userId");
    double sum = 0;
    if (listaI.isEmpty == false) {
      listaI.forEach((element) {
        sum += element.price;
      });
      var resp = await API.removeItems(id);
      if (resp.statusCode == 204) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Comprar finalizada"),
              content: Text("A sua compra de RS $sum foi finalizada"),
              actions: [
                ElevatedButton(
                  child: const Text("Confirmar"),
                  onPressed: () {
                    items();
                    Navigator.pop(context, false);
                  },
                )
              ],
            );
          },
        );
      }
    }
  }

  @override
  //Retorna os intens do carinho, se não tiver volta para home
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_bag),
          onPressed: finalizarCompra,
        ),
        appBar: AppBar(
          title: const Text("Carrinho"),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: listaI.isNotEmpty
            ? ListView.builder(
                itemCount: listaI.length,
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    child: ListTile(
                      title: Text("Produto ${listaI[i].product}"),
                      subtitle: Text("Preço RS ${listaI[i].price}"),
                    ),
                  );
                },
              )
            : const Center(
                child: Text("Sem items no carrinho"),
              ),
      ),
    );
  }
}
