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

class TokenInterceptor {
  final http.Client _inner = http.Client();
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  Future<http.Response> get(Uri path, {Map<String, String>? headers}) async {
    // Initialize headers if they are null
    headers ??= {};

    // Retrieve the access token
    final token = TokenManager.getAccessToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    var response = await _inner.get(path, headers: headers);

    if (response.statusCode == 401) {
      // Token might be expired, try to refresh
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Retry the request with the new token
        headers['Authorization'] = 'Bearer $newToken';
        var responseUpdated = await _inner.get(path, headers: headers);
        return responseUpdated;
      } else {
        // If refresh failed, redirect to login
        await _handleAuthFailure();
        throw Exception('Authentication failed');
      }
    }
    return response;
  }

  Future<http.Response> post(Uri path,
      {Map<String, String>? headers, Object? body}) async {
    headers ??= {};

    // Retrieve the access token
    final token = TokenManager.getAccessToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    var response = await _inner.post(path, headers: headers, body: body);
    if (response.statusCode == 401) {
      // Token might be expired, try to refresh
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Retry the request with the new token
        headers['Authorization'] = 'Bearer $newToken';
        var responseUpdated =
            await _inner.post(path, headers: headers, body: body);
        return responseUpdated;
      } else {
        // If refresh failed, redirect to login
        await _handleAuthFailure();
        throw Exception('Authentication failed');
      }
    }
    return response;
  }

  Future<http.Response> delete(Uri path,
      {Map<String, String>? headers, Object? body}) async {
    headers ??= {};

    // Retrieve the access token
    final token = TokenManager.getAccessToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    var response = await _inner.delete(path, headers: headers, body: body);
    if (response.statusCode == 401) {
      // Token might be expired, try to refresh
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Retry the request with the new token
        headers['Authorization'] = 'Bearer $newToken';
        var responseUpdated =
            await _inner.delete(path, headers: headers, body: body);
        return responseUpdated;
      } else {
        // If refresh failed, redirect to login
        await _handleAuthFailure();
        throw Exception('Authentication failed');
      }
    }
    return response;
  }

  // Future<http.Response> send(Future<http.Response> Function() request) async {
  //   try {
  //     var response = await request();

  //     if (response.statusCode == 401) {
  //       // Token might be expired, try to refresh
  //       final newToken = await _refreshToken();
  //       if (newToken != null) {
  //         // Retry the request with the new token
  //       } else {
  //         // If refresh failed, redirect to login
  //         await _handleAuthFailure();
  //         throw Exception('Authentication failed');
  //       }
  //     } else if (response.statusCode == 403) {
  //       await _handleForbiddenAccess(response);
  //     }

  //     return response;
  //   } catch (e) {
  //     log('Error in token interceptor: custom error');
  //     throw e;
  //   }
  // }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = TokenManager.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        _handleAuthFailure();
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

      if (response.statusCode == 400) {
        await _handleAuthFailure();
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

  Future<void> _handleForbiddenAccess(Response response) async {
    final responseBody = await response.body;
    final jsonData = jsonDecode(responseBody);
    final forbiddenAccessResponse = ForbiddenAccessResponse.fromJson(jsonData);

    if (forbiddenAccessResponse.message == FORBIDDEN_ACCESS) {
      log("Forbidden access detected");
      await TokenManager.deleteTokens();
      log("Invalid session detected");
      await _handleAuthFailure();
      // Handle forbidden access (e.g., show an error message)
    } else if (forbiddenAccessResponse.message == INVALID_SESSION) {
      await TokenManager.deleteTokens();
      log("Invalid session detected");
      await _handleAuthFailure();
    } else {
      log("Status 403: other error");
      await TokenManager.deleteTokens();
      log("Invalid session detected");
      await _handleAuthFailure();
    }
  }
}

final TokenInterceptor httpClient = TokenInterceptor();
