class RefreshAccessTokenResponse {
  final bool success;
  final AuthenticationData? data; // Make data nullable
  final String message;

  RefreshAccessTokenResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory RefreshAccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshAccessTokenResponse(
      success: json['success'],
      data: json['data'] != null
          ? AuthenticationData.fromJson(json['data'])
          : null,
      message: json['message'],
    );
  }
}

class AuthenticationData {
  final String? accessToken;
  final String? refreshToken;
  final String? loginSessionHash;
  final bool? relogin; // New field to indicate if re-login is required

  AuthenticationData({
    this.accessToken,
    this.refreshToken,
    this.loginSessionHash,
    this.relogin,
  });

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      loginSessionHash: json['loginSessionHash'],
      relogin: json['relogin'],
    );
  }
}
