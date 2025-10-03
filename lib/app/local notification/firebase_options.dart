import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions are only configured for Android.',
      );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDL8wQqC78XFnRIsAfi2SO2ub0yCuooUMU',
    appId: '1:879371568084:android:b5ec97c537723d5694cc41',
    messagingSenderId: '879371568084',
    projectId: 'organicbazzars',
    storageBucket: 'organicbazzars.firebasestorage.app',
  );
}
