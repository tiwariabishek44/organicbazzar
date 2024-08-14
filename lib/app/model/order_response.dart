class CourseBuyResponse {
  bool? success;
  String? data;
  String? message;

  CourseBuyResponse({
    this.success,
    this.data,
    this.message,
  });

  factory CourseBuyResponse.fromJson(Map<String, dynamic> json) =>
      CourseBuyResponse(
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
