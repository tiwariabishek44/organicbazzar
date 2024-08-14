import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/forbidden_access_response.dart';
import 'package:organicbazzar/app/model/refresh_access_token.dart';
import 'package:organicbazzar/app/utils/token_utils.dart';
import 'package:organicbazzar/app/widget/onboarding_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/forbidden_access_response.dart';
import 'package:organicbazzar/app/utils/token_utils.dart';
import 'package:organicbazzar/app/widget/onboarding_screen.dart';

const String FORBIDDEN_ACCESS = "FORBIDDEN_ACCESS";
const String INVALID_SESSION = "INVALID_SESSION";

class TokenInterceptor extends http.BaseClient {
  final http.Client _inner = http.Client();
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!request.headers.containsKey('Authorization')) {
      final token = TokenManager.getAccessToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
    }

    var response = await _inner.send(request);

    if (response.statusCode == 401) {
      // Token might be expired, try to refresh
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Retry the request with the new token
        request.headers['Authorization'] = 'Bearer $newToken';
        return _inner.send(request);
      } else {
        // If refresh failed, redirect to login
        await _handleAuthFailure();
        throw Exception('Authentication failed');
      }
    } else if (response.statusCode == 403) {
      await _handleForbiddenAccess(response);
    }

    return response;
  }

  Future<String?> _refreshToken() async {
    if (_isRefreshing) {
      await _refreshCompleter?.future;
      return TokenManager.getAccessToken();
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    try {
      final refreshToken = TokenManager.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw Exception('No refresh token available');
      }

      final response = await http.post(
        Uri.parse(ApiEndpoints.refreshAccessToken),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"refreshTOken": refreshToken}), // Fixed typo here
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final newAccessToken = jsonResponse['data']['accessToken'];
          await TokenManager.setAccessToken(newAccessToken);
          return newAccessToken;
        }
      }

      throw Exception('Failed to refresh token');
    } catch (e) {
      log('Error refreshing token: $e');
      return null;
    } finally {
      _isRefreshing = false;
      _refreshCompleter?.complete();
    }
  }

  Future<void> _handleAuthFailure() async {
    await TokenManager.deleteTokens();
    Get.offAll(() => OnboardingScreen());
  }

  Future<void> _handleForbiddenAccess(http.StreamedResponse response) async {
    final responseBody = await response.stream.bytesToString();
    final jsonData = jsonDecode(responseBody);
    final forbiddenAccessResponse = ForbiddenAccessResponse.fromJson(jsonData);

    if (forbiddenAccessResponse.message == FORBIDDEN_ACCESS) {
      log("Forbidden access detected");
      // Handle forbidden access (e.g., show an error message)
    } else if (forbiddenAccessResponse.message == INVALID_SESSION) {
      await TokenManager.deleteTokens();
      log("Invalid session detected");
      await _handleAuthFailure();
    } else {
      log("Status 403: other error");
    }
  }
}

final TokenInterceptor httpClient = TokenInterceptor();
