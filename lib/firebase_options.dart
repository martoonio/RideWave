// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDlN7pUZ_oPhroD-gHODW-f6uQ1sR6fH4Y',
    appId: '1:1036123971540:web:0cfc67784ab6ad8db90041',
    messagingSenderId: '1036123971540',
    projectId: 'ridewave-a250b',
    authDomain: 'ridewave-a250b.firebaseapp.com',
    databaseURL: 'https://ridewave-a250b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ridewave-a250b.appspot.com',
    measurementId: 'G-C1RFR9N7BT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9YjZ3Zo_PqDtzu_qNQjCzkxxUseMRM3Q',
    appId: '1:1036123971540:android:7ebcf4e4136a388ab90041',
    messagingSenderId: '1036123971540',
    projectId: 'ridewave-a250b',
    databaseURL: 'https://ridewave-a250b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ridewave-a250b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIRO0st4LXkFNJwUrbur-23MLgqyFhogY',
    appId: '1:1036123971540:ios:db19233836a4b8ddb90041',
    messagingSenderId: '1036123971540',
    projectId: 'ridewave-a250b',
    databaseURL: 'https://ridewave-a250b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ridewave-a250b.appspot.com',
    androidClientId: '1036123971540-c3t7eoqstqcabk2d6p7pfr5q3jiq7he6.apps.googleusercontent.com',
    iosClientId: '1036123971540-tupm7rnctnfdjc6166ck6idi1qhg1qfg.apps.googleusercontent.com',
    iosBundleId: 'com.example.ridewave',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIRO0st4LXkFNJwUrbur-23MLgqyFhogY',
    appId: '1:1036123971540:ios:73dd4a9967b11cf2b90041',
    messagingSenderId: '1036123971540',
    projectId: 'ridewave-a250b',
    databaseURL: 'https://ridewave-a250b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ridewave-a250b.appspot.com',
    androidClientId: '1036123971540-c3t7eoqstqcabk2d6p7pfr5q3jiq7he6.apps.googleusercontent.com',
    iosClientId: '1036123971540-2f6u5fsaj3klpfo55ttmpfaqq06cnj40.apps.googleusercontent.com',
    iosBundleId: 'com.example.ridewave.RunnerTests',
  );
}
