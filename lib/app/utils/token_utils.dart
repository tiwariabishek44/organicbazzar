// TO SAVE THE TOKENS LOCALLY

import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/config/prefs.dart';

class TokenManager {
  static final box = GetStorage();

  static Future<void> setAccessToken(String? accessToken) async {
    await box.write(accessTokenKey, accessToken);
  }

  static String? getAccessToken() {
    return box.read(accessTokenKey);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    await box.write(refreshTokenKey, refreshToken);
  }

  static String? getRefreshToken() {
    return box.read(refreshTokenKey);
  }

  static Future<void> deleteTokens() async {
    await box.remove(accessTokenKey);
    await box.remove(refreshTokenKey);
  }
}
