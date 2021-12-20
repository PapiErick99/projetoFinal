import 'dart:convert';

import "package:http/http.dart" as http;

String base_url = "http://192.168.0.231:3000/api";

Map<String, String> headers = {
  "Accept": "application/json",
  "Content-Type": "application/json"
};

class API {
  static Future<http.Response> newAccount(name, email, password) async {
    var resp = await http.post(Uri.parse("$base_url/users"),
        headers: headers,
        body: jsonEncode({"name": name, "email": email, "password": password}));
    return resp;
  }

  static Future<http.Response> login(email, password) async {
    var resp = await http.post(Uri.parse("$base_url/users/auth"),
        headers: headers,
        body: jsonEncode({"email": email, "password": password}));
    return resp;
  }

  static Future<http.Response> getProducts() async {
    var resp =
        await http.get(Uri.parse("$base_url/products"), headers: headers);
    return resp;
  }

  static Future<http.Response> newProduct(
      name, quantity, category, price) async {
    var resp = await http.post(Uri.parse("$base_url/products"),
        headers: headers,
        body: jsonEncode({
          "name": name,
          "quantity": quantity,
          "category": category,
          "price": price
        }));
    return resp;
  }

  static Future<http.Response> addItem(userId, product, price) async {
    var resp = await http.post(Uri.parse("$base_url/items"),
        headers: headers,
        body:
            jsonEncode({"userId": userId, "product": product, "price": price}));
    return resp;
  }

  static Future<http.Response> getItems(userId) async {
    var resp = await http.get(Uri.parse("$base_url/users/$userId/items"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> removeItems(userId) async {
    var resp = await http.delete(
        Uri.parse("$base_url/users/$userId/remove-items"),
        headers: headers);
    return resp;
  }
}
