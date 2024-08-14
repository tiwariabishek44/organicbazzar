class ForgetPasswordResponse {
  bool success;
  String data;
  String message;

  ForgetPasswordResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordResponse(
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
