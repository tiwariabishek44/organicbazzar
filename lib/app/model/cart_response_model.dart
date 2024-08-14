class CartItem {
  final int productId;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final double rate;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.image,
    required this.rate,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'rate': rate,
    };
  }

  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: this.productId,
      name: this.name,
      price: this.price,
      quantity: quantity ?? this.quantity,
      image: this.image,
      rate: this.rate,
    );
  }
}
