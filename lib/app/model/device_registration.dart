class DeviceRegistrationResponse {
  bool success;
  String data;
  String message;

  DeviceRegistrationResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DeviceRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      DeviceRegistrationResponse(
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
