import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/modules/connectivity%20/connectivity_controller.dart';
import 'package:organicbazzar/app/widget/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/local notification/firebase_options.dart';
import 'app/local notification/push_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// Function to listen to background notifications
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification received");
  }
}

// Handle notifications in the foreground on web platform
void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

void main() async {
  Get.put(ConnectivityController());
  await GetStorage.init();

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Handle background notification tap
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      log("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  PushNotifications.init();

  // Only initialize local notifications if platform is not web
  if (!kIsWeb) {
    PushNotifications.localNotiInit();
  }

  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    log("Got a message in foreground");
    if (message.notification != null) {
      if (kIsWeb) {
        showNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
        );
      } else {
        PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
        );
      }
    }
  });

  // Handle notifications when the app is launched from a terminated state
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    log("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!
          .pushNamed("/message", arguments: initialMessage);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
//  it say that the code ofthe version has already been updated and the code is not updated so it is not working    so i have to update the code
//  so i have to update the code   in the play stroe os i am doing he nonsense things here
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return WillPopScope(
          onWillPop: () async {
            // Check if the current route is the initial route
            if (Get.currentRoute == '/') {
              // Show confirmation dialog
              return await Get.dialog<bool>(
                    AlertDialog(
                      title: Text('Exit App'),
                      content: Text('Are you sure you want to exit?'),
                      actions: [
                        TextButton(
                          child: Text('No'),
                          onPressed: () => Get.back(result: false),
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () => Get.back(result: true),
                        ),
                      ],
                    ),
                  ) ??
                  false;
            }
            // If not on the initial route, allow normal back navigation
            return true;
          },
          child: GetMaterialApp(
            initialBinding: BindingsBuilder(() {
              Get.put(ConnectivityController());
            }),
            debugShowCheckedModeBanner: false,
            title: 'Organic Bazzar',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColor.backgroundColor),
              useMaterial3: true,
            ),
            home: SplashScreen(),
            navigatorKey: navigatorKey,
          ),
        );
      },
    );
  }
}
