class Product {
  int? id;
  String? type;
  String? name;
  int? quantity;

  Product({this.id, this.name, this.quantity, this.type});

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["id"],
      name: map["name"],
      quantity: map['quantity'],
      type: map['type'],
    );
  }
}
