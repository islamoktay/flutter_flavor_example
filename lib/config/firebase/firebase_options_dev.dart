// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_dev.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPLyH8RsjZYrwdOG90N6uIHFmQ715rUO4',
    appId: '1:821853266653:android:ddeeadec683685c6a5b134',
    messagingSenderId: '821853266653',
    projectId: 'ahmetislam-flutter-flavor',
    storageBucket: 'ahmetislam-flutter-flavor.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3iUQNecNH4ddOw3_y2W3f4Wm0pml_798',
    appId: '1:821853266653:ios:731b8ebd0ccfafc8a5b134',
    messagingSenderId: '821853266653',
    projectId: 'ahmetislam-flutter-flavor',
    storageBucket: 'ahmetislam-flutter-flavor.appspot.com',
    iosClientId: '821853266653-5cmju83ah8fo799unsts48e4q8cd651u.apps.googleusercontent.com',
    iosBundleId: 'com.ahmetislam.flutterFlavorExample.dev',
  );
}
