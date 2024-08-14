class OrderResponseModel {
  bool success;
  String data;
  String message;

  OrderResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        success: json["success"],
        data: json["data"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
      };
}
