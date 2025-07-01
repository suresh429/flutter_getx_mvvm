import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform. Only Android and iOS are supported.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHRYDme6lQxCbtEujV_ddznePwTq84i2M',
    appId: '1:337428230933:android:2314e867dbb48bef556f1c',
    messagingSenderId: '337428230933',
    projectId: 'touch-a-life-dev',
    storageBucket: 'touch-a-life-dev.appspot.com',
    databaseURL: 'https://touch-a-life-dev.firebaseio.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAf3BTtlahNvI408DvGCtbHcXW3WL8xB-k',
    appId: '1:337428230933:ios:927370db8112c083556f1c',
    messagingSenderId: '337428230933',
    projectId: 'touch-a-life-dev',
    storageBucket: 'touch-a-life-dev.appspot.com',
    iosClientId: '337428230933-6shkh196o90tmjjkdnusq6lo8lrage4g.apps.googleusercontent.com',
    iosBundleId: 'com.touchalife.talleaders',
    databaseURL: 'https://touch-a-life-dev.firebaseio.com',
  );
}
