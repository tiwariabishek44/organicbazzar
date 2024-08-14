class ForbiddenAccessResponse {
  final bool success;
  final String data;
  final String message;

  ForbiddenAccessResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ForbiddenAccessResponse.fromJson(Map<String, dynamic> json) {
    return ForbiddenAccessResponse(
      success: json['success'],
      data: json['data'],
      message: json['message'],
    );
  }
}
