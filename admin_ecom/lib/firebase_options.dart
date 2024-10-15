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
    apiKey: 'AIzaSyAXhVTLYSTtRYui2Xp4Vjt91H0yVquKsfM',
    appId: '1:1091294824026:web:cb32c78f4f5b42251d3a63',
    messagingSenderId: '1091294824026',
    projectId: 'ecommerceapp-bb2323',
    authDomain: 'ecommerceapp-bb2323.firebaseapp.com',
    storageBucket: 'ecommerceapp-bb2323.appspot.com',
    measurementId: 'G-JK8HGEDGRN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqVi0Ux3A28Cw2FyAG47cXbVeB-7hWPW4',
    appId: '1:1091294824026:android:18f46d65c1295e611d3a63',
    messagingSenderId: '1091294824026',
    projectId: 'ecommerceapp-bb2323',
    storageBucket: 'ecommerceapp-bb2323.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyng5aPjYuWbANmhQXoPeJes23ReXEFl4',
    appId: '1:1091294824026:ios:491055f35a1959401d3a63',
    messagingSenderId: '1091294824026',
    projectId: 'ecommerceapp-bb2323',
    storageBucket: 'ecommerceapp-bb2323.appspot.com',
    iosBundleId: 'com.example.adminEcom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyng5aPjYuWbANmhQXoPeJes23ReXEFl4',
    appId: '1:1091294824026:ios:491055f35a1959401d3a63',
    messagingSenderId: '1091294824026',
    projectId: 'ecommerceapp-bb2323',
    storageBucket: 'ecommerceapp-bb2323.appspot.com',
    iosBundleId: 'com.example.adminEcom',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXhVTLYSTtRYui2Xp4Vjt91H0yVquKsfM',
    appId: '1:1091294824026:web:3cbbadab54b78c3b1d3a63',
    messagingSenderId: '1091294824026',
    projectId: 'ecommerceapp-bb2323',
    authDomain: 'ecommerceapp-bb2323.firebaseapp.com',
    storageBucket: 'ecommerceapp-bb2323.appspot.com',
    measurementId: 'G-R9LCSMM5YZ',
  );
}
