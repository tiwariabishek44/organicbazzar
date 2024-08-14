class ProductResponse {
  int id;
  String name;
  String description;
  double price; // Changed from int to double
  String filePath;
  String stockStatus;
  String productType;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.filePath,
    required this.stockStatus,
    required this.productType,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(), // Convert int to double
        filePath: json["filePath"],
        stockStatus: json["stockStatus"],
        productType: json["productType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "filePath": filePath,
        "stockStatus": stockStatus,
        "productType": productType,
      };
}
