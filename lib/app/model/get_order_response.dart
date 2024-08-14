class GetOrderResponse {
  bool success;
  List<Orders> data;
  String message;

  GetOrderResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetOrderResponse.fromJson(Map<String, dynamic> json) =>
      GetOrderResponse(
        success: json["success"],
        data: List<Orders>.from(json["data"].map((x) => Orders.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Orders {
  int id;
  List<OrderDetail> orderDetails;
  String customerEmail;
  String customerName;
  String customerPhone;
  String customerAddress;
  String status;
  String creationDate;

  Orders({
    required this.id,
    required this.orderDetails,
    required this.customerEmail,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.status,
    required this.creationDate,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"],
        orderDetails: List<OrderDetail>.from(
            json["orderDetails"].map((x) => OrderDetail.fromJson(x))),
        customerEmail: json["customerEmail"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        customerAddress: json["customerAddress"],
        status: json["status"],
        creationDate: json["creationDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
        "customerEmail": customerEmail,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "customerAddress": customerAddress,
        "status": status,
        "creationDate": creationDate,
      };
}

class OrderDetail {
  int id;
  Product product;
  double quantity; //

  OrderDetail({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson,
        "quantity": quantity,
      };
}

class Product {
  int id;
  String name;
  String description;
  double price;
  String filePath;
  String stockStatus;
  String productType;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.filePath,
    required this.stockStatus,
    required this.productType,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(), // Ensure price is converted to double
        filePath: json["filePath"],
        stockStatus: json["stockStatus"],
        productType: json["productType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price, // No need to change, as `price` is already a double
        "filePath": filePath,
        "stockStatus": stockStatus,
        "productType": productType,
      };
}
