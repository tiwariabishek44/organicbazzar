class ContactUsResponse {
  bool? success;
  String? data;
  String? message;

  ContactUsResponse({
    this.success,
    this.data,
    this.message,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      ContactUsResponse(
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
