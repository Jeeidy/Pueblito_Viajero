import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'opciones_firebase.dart';
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
    apiKey: 'AIzaSyB3gamtyL1BJB8EejPILSVOoqE4JCOFFxs',
    appId: '1:315768036614:web:ddb50fe3240cd8ca809287',
    messagingSenderId: '315768036614',
    projectId: 'pueblito-viajero',
    authDomain: 'pueblito-viajero.firebaseapp.com',
    storageBucket: 'pueblito-viajero.appspot.com',
    measurementId: 'G-QN8NF0561D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3aOE7ikKVAvGln5i3rFz-79F9xZymTtk',
    appId: '1:315768036614:android:ed2da7ebff13031e809287',
    messagingSenderId: '315768036614',
    projectId: 'pueblito-viajero',
    storageBucket: 'pueblito-viajero.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvQsNgaH_svKbuZpcMkImm57iieDP7VcA',
    appId: '1:315768036614:ios:6191294a0b02eb35809287',
    messagingSenderId: '315768036614',
    projectId: 'pueblito-viajero',
    storageBucket: 'pueblito-viajero.appspot.com',
    iosBundleId: 'com.example.pueblitoViajero',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB3gamtyL1BJB8EejPILSVOoqE4JCOFFxs',
    appId: '1:315768036614:web:63b88e8df225001b809287',
    messagingSenderId: '315768036614',
    projectId: 'pueblito-viajero',
    authDomain: 'pueblito-viajero.firebaseapp.com',
    storageBucket: 'pueblito-viajero.appspot.com',
    measurementId: 'G-7NV74B0RGH',
  );
}
