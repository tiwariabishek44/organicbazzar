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
    apiKey: 'AIzaSyDiusm8gdQ7rFKymRH33hNVbG2uTjoVMZg',
    appId: '1:296348372039:android:627744bb20245c4760b562',
    messagingSenderId: '296348372039',
    projectId: 'organicbazzar-18d9f',
    storageBucket: 'organicbazzar-18d9f.appspot.com',
  );
}
