// To parse this JSON data, do
//
//     final registerPhase1Response = registerPhase1ResponseFromJson(jsonString);

import 'dart:convert';

class RegisterResponseModel {
  bool success;
  String data;
  String message;

  RegisterResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
