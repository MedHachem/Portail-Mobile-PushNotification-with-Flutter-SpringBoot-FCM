import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    return const FirebaseOptions(
      appId: '1:1088572728121:android:3dae329a9b5d4034d9bee8',
      apiKey: 'AIzaSyAyov70k9XTMZrD3xARTn5E_q2K5Eyeh4I',
      projectId: 'gtinfoapp-92ddf',
      androidClientId:
          '1088572728121-0ip0053qg8ghs39k3e7qjr4bqpa6b0n5.apps.googleusercontent.com',
      // we can find it from firebase/project setting /  Cloud Messaging
      messagingSenderId: '1088572728121',
      // we can find it from firebase/ Authentication /Sign-in method
      authDomain: 'gtinfoapp-92ddf.firebaseapp.com',
    );
    // }
  }
}
