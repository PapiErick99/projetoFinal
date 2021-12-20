class Product {
  String id;
  String name;
  int quantity;
  double price;
  Product(this.id, this.name, this.quantity, this.price);
  Product.fromJson(Map json)
      : id = json["_id"],
        name = json["name"],
        quantity = json["quantity"],
        price = json["price"];
}
