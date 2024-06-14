class Cart {
  final int id;
  final String name;
  final double price;
  int quantity;

  Cart({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
