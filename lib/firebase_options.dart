// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBiaOCIZywGtcnZS-f1JFVmXwe8Kq3Y-0k',
    appId: '1:574237349811:web:66c38756bc1f266eaf1dc6',
    messagingSenderId: '574237349811',
    projectId: 'pkart-43baf',
    authDomain: 'pkart-43baf.firebaseapp.com',
    databaseURL: 'https://pkart-43baf-default-rtdb.firebaseio.com',
    storageBucket: 'pkart-43baf.appspot.com',
    measurementId: 'G-J93KV1B7VC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdyz7v4KcuEk_4_Dx1QD3ePcCU_lI3VTM',
    appId: '1:574237349811:android:1a4b753d506b044baf1dc6',
    messagingSenderId: '574237349811',
    projectId: 'pkart-43baf',
    databaseURL: 'https://pkart-43baf-default-rtdb.firebaseio.com',
    storageBucket: 'pkart-43baf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl2EU0T274Dz7ZsFTADv0EO-7sSKxP_Tg',
    appId: '1:574237349811:ios:b8f541a626051169af1dc6',
    messagingSenderId: '574237349811',
    projectId: 'pkart-43baf',
    databaseURL: 'https://pkart-43baf-default-rtdb.firebaseio.com',
    storageBucket: 'pkart-43baf.appspot.com',
    iosBundleId: 'com.example.spotifyClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl2EU0T274Dz7ZsFTADv0EO-7sSKxP_Tg',
    appId: '1:574237349811:ios:b8f541a626051169af1dc6',
    messagingSenderId: '574237349811',
    projectId: 'pkart-43baf',
    databaseURL: 'https://pkart-43baf-default-rtdb.firebaseio.com',
    storageBucket: 'pkart-43baf.appspot.com',
    iosBundleId: 'com.example.spotifyClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBiaOCIZywGtcnZS-f1JFVmXwe8Kq3Y-0k',
    appId: '1:574237349811:web:56279834b82776b7af1dc6',
    messagingSenderId: '574237349811',
    projectId: 'pkart-43baf',
    authDomain: 'pkart-43baf.firebaseapp.com',
    databaseURL: 'https://pkart-43baf-default-rtdb.firebaseio.com',
    storageBucket: 'pkart-43baf.appspot.com',
    measurementId: 'G-BJHRYY86G9',
  );
}
