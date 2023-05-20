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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDV4_q5FDCikfoCjAmlgToK6-BS58q9Mmo',
    appId: '1:767406330830:web:fae67450f8dd969458919f',
    messagingSenderId: '767406330830',
    projectId: 'izzycasa',
    authDomain: 'izzycasa.firebaseapp.com',
    storageBucket: 'izzycasa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmjv2Cywz4a08_ruGvEfJtKjINZouKWYA',
    appId: '1:767406330830:android:3d0f15efef60de8758919f',
    messagingSenderId: '767406330830',
    projectId: 'izzycasa',
    storageBucket: 'izzycasa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQvPNIRetCg8kQJnZ7YrHQsP7iPhp9lNA',
    appId: '1:767406330830:ios:bfb9e010698be55558919f',
    messagingSenderId: '767406330830',
    projectId: 'izzycasa',
    storageBucket: 'izzycasa.appspot.com',
    iosClientId: '767406330830-hlt4g83d956g4q5nfjudv3re6vcrp4d7.apps.googleusercontent.com',
    iosBundleId: 'com.example.izzyHouseApp',
  );
}
