import 'package:flutter/material.dart';
import 'package:gtiapp/Services/AuthentifcationService.dart';
import 'package:gtiapp/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List?> fetchInfo() {
  AuthService auth = AuthService();
  return auth.fetchInfo();
}

class MyProfileApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromARGB(255, 111, 140, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/acceuil');
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications_sharp,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/list');
              },
            ),
            IconButton(
              icon: Icon(Icons.account_box,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              },
            ),
            IconButton(
              icon:
                  Icon(Icons.logout, color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('matricule');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                );
              },
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: Container(
                        alignment: Alignment(0.0, 4.5),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/user.jpg"),
                          radius: 60.0,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 60,
            ),
            FutureBuilder(
              future: fetchInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text("no data"));
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                return Center(
                  child: Text(
                    snapshot.data?[0] + ' ' + snapshot.data?[1],
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 6),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: fetchInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text("no data"));
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                return Center(
                  child: Text(
                    snapshot.data?[5],
                    style: TextStyle(
                        color: Color(0x6EFF0000),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "App Developer at GTI Company",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                elevation: 2.0,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    child: Text(
                      "Contact",
                      style: TextStyle(
                          letterSpacing: 2.0, fontWeight: FontWeight.w300),
                    ))),
            SizedBox(
              height: 15,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          FutureBuilder(
                            future: fetchInfo(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: Text("no data"));
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text("Something went wrong"));
                              }

                              return Center(
                                child: Text(
                                  snapshot.data?[2],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Mobile",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          FutureBuilder(
                            future: fetchInfo(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: Text("no data"));
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text("Something went wrong"));
                              }

                              return Center(
                                child: Text(
                                  '+216 ' + snapshot.data?[4],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: makeBottom,
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse('http://www.gtiinfo.com.tn');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
