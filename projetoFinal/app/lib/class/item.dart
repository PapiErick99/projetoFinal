class Item {
  String id;
  String product;
  double price;
  Item(this.id, this.product, this.price);
  Item.fromJson(Map json)
      : id = json["_id"],
        product = json["product"],
        price = json["price"];
}
