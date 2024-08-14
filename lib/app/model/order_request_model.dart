class OrderProduct {
  int productId;
  int quantity;

  OrderProduct({required this.productId, required this.quantity});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

class OrderRequest {
  List<OrderProduct> products;

  OrderRequest({required this.products});

  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    return OrderRequest(
      products: List<OrderProduct>.from(
          json['products'].map((x) => OrderProduct.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}
