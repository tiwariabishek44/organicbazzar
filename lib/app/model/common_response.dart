class CommonResponse {
  String message;
  bool success;

  CommonResponse({
    required this.message,
    required this.success,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
      };
}
