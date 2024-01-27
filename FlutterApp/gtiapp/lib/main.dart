import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gtiapp/Views/Application.dart';
import 'package:gtiapp/Views/ProfilePage.dart';
import 'package:gtiapp/Views/SplashScreen.dart';
import 'package:gtiapp/Views/home.dart';
import 'package:gtiapp/Views/login.dart';
import 'package:gtiapp/Views/notification_details.dart';
import 'package:gtiapp/Views/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(MaterialApp(
    home: new MyApp(),
    routes: {
      '/acceuil': (context) => Homepage(),
      '/Connexion': (context) => MyLogin(),
      '/message': (context) => MessageView(),
      '/list': (context) => Application(),
      '/profil': (context) => MyProfileApp(),
    },
  ));
  await Firebase.initializeApp(
    /// ToDO change your data ///
    options: const FirebaseOptions(
        appId: '1:1088572728121:android:3dae329a9b5d4034d9bee8',
        apiKey: 'AIzaSyAyov70k9XTMZrD3xARTn5E_q2K5Eyeh4I',
        messagingSenderId: '1088572728121',
        projectId: 'gtinfoapp-92ddf'),
  );
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<RemoteMessage> _messages = [];

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var obtainedEmail = sharedPreferences.getString('matricule');
    obtainedToken = "";
    finalEmail = "";
    setState(() async {
      if (obtainedEmail == null) {
        finalEmail = "";
      } else {
        finalEmail = obtainedEmail;
      }
    });
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
    getValidationData().whenComplete(() {
      Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        finalEmail == "" ? MyLogin() : Homepage()),
              ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Container(
              alignment: Alignment(0.0, 4.5),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/téléchargement.jpg"),
                radius: 80.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    ));
  }
}
