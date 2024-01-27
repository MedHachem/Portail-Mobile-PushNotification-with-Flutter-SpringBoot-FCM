import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gtiapp/Views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/custom_form_button.dart';
import '../Services/login_service.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

late String mat;
Service service = Service();

class _MyLoginState extends State<MyLogin> {
  TextEditingController MatriculeController = TextEditingController();
  TextEditingController PassowordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _loginFormKey = GlobalKey<FormState>();
  //create the service class object

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 100,
                        child: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png')),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png')))),
                      ),
                      Positioned(
                          right: 25,
                          top: 0,
                          width: 100,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/GTILOGO.png'))),
                          )),
                      Positioned(
                          child: Container(
                        margin: EdgeInsets.only(top: 90),
                        child: Center(
                          child: Text(
                            "Bienvenue!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                  controller: MatriculeController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Matricule',
                                      hintText: 'Saisir votre matricule',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: (textValue) {
                                    if (textValue == null ||
                                        textValue.isEmpty) {
                                      return 'Merci de vérifier votre Matricule !';
                                    }

                                    return null;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: PassowordController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Mot de passe',
                                      hintText: 'Saisir votre mot de passe',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  obscureText: true,
                                  validator: (textValue) {
                                    if (textValue == null ||
                                        textValue.isEmpty) {
                                      return 'Merci de vérifier votre mot de passe!';
                                    }

                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                            child: CustomFormButton(
                              innerText: 'Connexion',
                              onPressed: () async {
                                _handleLoginUser();
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    'matricule', MatriculeController.text);

                                Get.to(MyLogin());
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkmatricule() async {
    if (service.checkIfUserexist(MatriculeController.text) == false) {
      _handleLoginUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Utilisateur déjà inscrit avec cette matricule..'),
        ),
      );
    }
  }

  void _handleLoginUser() async {
    // login user
    // ignore: unrelated_type_equality_checks
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enregistrement des données..'),
        ),
      );
      _firebaseMessaging.getToken().then((value) => service.saveUser(
            MatriculeController.text,
            PassowordController.text,
            value!,
          ));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    }
  }
}
