import 'dart:convert';

import 'package:app/api.dart';
import 'package:app/class/product.dart';
import 'package:app/screens/carrinho.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/new_product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Product> listaP = List<Product>.empty();
  _DashBoardState() {
    products();
  }
  // converte json para objeto
  //Percore cada elemento e converte para produto e lista
  void products() async {
    var resp = await API.getProducts();
    setState(() {
      Iterable aux = json.decode(resp.body);
      listaP = aux.map((json) => Product.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewProduct(),
              ),
            );
            if (result) {
              products();
            }
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Compre!"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Carrinho(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("userId");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: listaP.length,
          itemBuilder: (BuildContext context, int i) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Card(
                  child: ListTile(
                    title: Text("Produto: ${listaP[i].name}"),
                    subtitle: Text("Preço RS ${listaP[i].price}"),
                    leading: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? id = prefs.getString("userId");
                        var resp = await API.addItem(
                            id, listaP[i].name, listaP[i].price);
                        if (resp.statusCode == 201) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Carrinho(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
