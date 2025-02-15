import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCxggKszLUK98d1OEIoC4hYm08jn1mIHw',
    appId: '1:553916064649:android:0fd46e6a1468da76803758',
    messagingSenderId: '553916064649',
    projectId: 'mrp4002-826ef',
    storageBucket: 'mrp4002-826ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA68SWRsJNhJDOcRWwGk5UnBIWNsxXCTi0',
    appId: '1:553916064649:ios:020016064ef799d7803758',
    messagingSenderId: '553916064649',
    projectId: 'mrp4002-826ef',
    storageBucket: 'mrp4002-826ef.appspot.com',
    iosBundleId: 'com.example.mrp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDSYe4HbGrBOX-iifxfhpBkR-UuLsX5EzM',
    appId: '1:553916064649:web:0857c4205b1e9efa803758',
    messagingSenderId: '553916064649',
    projectId: 'mrp4002-826ef',
    authDomain: 'mrp4002-826ef.firebaseapp.com',
    storageBucket: 'mrp4002-826ef.appspot.com',
  );
}
