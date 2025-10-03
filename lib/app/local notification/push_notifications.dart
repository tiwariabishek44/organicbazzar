// File: push_notifications.dart
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/main.dart';
import '../modules/login/login_controller.dart';

class PushNotifications {
  static final LoginController loginController = Get.put(LoginController());
  static final FlutterRingtonePlayer _player = FlutterRingtonePlayer();
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await getFCMToken();
  }

  static Future<String?> getFCMToken({int maxRetries = 3}) async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        log("Device token: $token");
        final storage = GetStorage();
        storage.write('deviceId', token);
        storage.write('deviceType', GetPlatform.isAndroid ? 'android' : 'ios');
        return token;
      }
      return null;
    } catch (e) {
      log("Failed to get device token: $e");
      if (maxRetries > 0) {
        await Future.delayed(const Duration(seconds: 10));
        return getFCMToken(maxRetries: maxRetries - 1);
      }
      return null;
    }
  }

  static Future<void> localNotiInit() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        await showSimpleNotification(
          title: title ?? '',
          body: body ?? '',
          payload: payload ?? '',
        );
      },
    );

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );

    if (GetPlatform.isAndroid) {
      const androidChannel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Channel for important notifications',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      );

      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
    }
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState?.pushNamed(
      "/message",
      arguments: notificationResponse,
    );
  }

  // For foreground notifications
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    await _showNotification(title: title, body: body, payload: payload);
  }

  // For background notifications
  static Future<void> showBackgroundNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    await _showNotification(title: title, body: body, payload: payload);
  }

  // Common notification display logic
  static Future<void> _showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    await _player.play(
      fromAsset: "assets/notification_sound.mp3",
      volume: 1.0,
      looping: false,
    );

    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Channel for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      enableVibration: true,
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
