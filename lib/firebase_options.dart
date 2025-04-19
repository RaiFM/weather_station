// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyAERUPQvMjDypPUY1hB6bS-FMQqdPtVmZM',
    appId: '1:626467315932:web:29f33368b8c5690067d419',
    messagingSenderId: '626467315932',
    projectId: 'weather-station-2ams',
    authDomain: 'weather-station-2ams.firebaseapp.com',
    databaseURL: 'https://weather-station-2ams-default-rtdb.firebaseio.com',
    storageBucket: 'weather-station-2ams.firebasestorage.app',
    measurementId: 'G-MK54NX4XQJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZPc4WrzCly9rpGstmZ1KZJD30_Das1Lw',
    appId: '1:626467315932:android:753b78016cee5f5367d419',
    messagingSenderId: '626467315932',
    projectId: 'weather-station-2ams',
    databaseURL: 'https://weather-station-2ams-default-rtdb.firebaseio.com',
    storageBucket: 'weather-station-2ams.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKUUT3KGxbcicmMuL8Nte2zwdGRzkPVcU',
    appId: '1:626467315932:ios:6aefd35c5b03561667d419',
    messagingSenderId: '626467315932',
    projectId: 'weather-station-2ams',
    databaseURL: 'https://weather-station-2ams-default-rtdb.firebaseio.com',
    storageBucket: 'weather-station-2ams.firebasestorage.app',
    iosBundleId: 'com.example.weatherStation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKUUT3KGxbcicmMuL8Nte2zwdGRzkPVcU',
    appId: '1:626467315932:ios:6aefd35c5b03561667d419',
    messagingSenderId: '626467315932',
    projectId: 'weather-station-2ams',
    databaseURL: 'https://weather-station-2ams-default-rtdb.firebaseio.com',
    storageBucket: 'weather-station-2ams.firebasestorage.app',
    iosBundleId: 'com.example.weatherStation',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAERUPQvMjDypPUY1hB6bS-FMQqdPtVmZM',
    appId: '1:626467315932:web:57254c34d212016867d419',
    messagingSenderId: '626467315932',
    projectId: 'weather-station-2ams',
    authDomain: 'weather-station-2ams.firebaseapp.com',
    databaseURL: 'https://weather-station-2ams-default-rtdb.firebaseio.com',
    storageBucket: 'weather-station-2ams.firebasestorage.app',
    measurementId: 'G-KK6KDELXBV',
  );

}