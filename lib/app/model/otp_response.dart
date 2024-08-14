// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

class OtpResponse {
  bool? success;
  String? data;
  String? message;

  OtpResponse({
    this.success,
    this.data,
    this.message,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
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
