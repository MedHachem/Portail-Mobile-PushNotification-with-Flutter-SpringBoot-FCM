import 'package:flutter/material.dart';
import 'package:gtiapp/Services/AuthentifcationService.dart';
import 'package:gtiapp/Views/SplashScreen.dart';
import 'package:gtiapp/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

var secondaryColor = Color(0xFF5593f8);
var primaryColor = Color(0xFF48c9e2);

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

Future<List?> fetchInfo() {
  AuthService auth = AuthService();
  return auth.fetchInfo();
}

class _HomepageState extends State<Homepage> {
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var obtainedEmail = sharedPreferences.getString('matricule');
    finalEmail = "";
    setState(() {
      if (obtainedEmail == null) {
        finalEmail = "";
      } else {
        finalEmail = obtainedEmail;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void updateUI() {
    setState(() {
      //You can also make changes to your state here.
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      final makeBottom = Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromARGB(255, 111, 140, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon:
                    Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 255)),
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
                icon: Icon(Icons.logout,
                    color: Color.fromARGB(255, 255, 255, 255)),
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff5f7fa),
        body: Column(children: [
          Stack(
            children: [
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
                                  image:
                                      AssetImage('assets/images/GTILOGO.png'))),
                        )),
                    Positioned(
                        top: size.height * .25,
                        left: 30,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: fetchInfo(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: Text("no data"));
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Text("Something went wrong"));
                                    }

                                    return Center(
                                      child: Text(
                                        "Bienvenue " + snapshot.data?[0] + " !",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    );
                                  }),
                              Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 5),
                                  child: FutureBuilder(
                                      future: fetchInfo(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                              child: Text("no data"));
                                        } else if (snapshot.hasError) {
                                          return const Center(
                                              child:
                                                  Text("Something went wrong"));
                                        }

                                        return Center(
                                          child: Text(
                                            "[ " + snapshot.data?[3] + " ]",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        );
                                      })),
                            ]))
                  ],
                ),
              ),
            ],
          ),
          DevicesGridDashboard(size: size),
          DevicesGridDashboard1(),
        ]),
        bottomNavigationBar: makeBottom,
      );
    });
  }

  Padding CustomCard(Size size, context, String img) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: GestureDetector(
        child: Container(
          height: size.height * .5,
          width: size.width * .85,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(
                  '$img',
                ),
                fit: BoxFit.cover,
              )),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: size.height * .12),
              child: Text(
                '',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container GradientContainer(Size size) {
    return Container(
      height: size.height * .3,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  Icon icon;
  String title;
  CardWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 50,
        width: 200,
        child: Center(
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class DevicesGridDashboard extends StatelessWidget {
  const DevicesGridDashboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 236, 241, 199)),
            child: Text(
              "Notifications:",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 216, 150, 17)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.blue,
                  Icon(
                    Icons.work_history,
                    color: Colors.white,
                  ),
                  'WorkDay',
                  '8 News'),
              CardField(
                  size,
                  Colors.amber,
                  Icon(Icons.lightbulb_outline, color: Colors.white),
                  'Autres',
                  '8 News '),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.purple,
                  Icon(Icons.alarm, color: Colors.white),
                  'Absences',
                  '5 News '),
              CardField(
                  size,
                  Colors.green,
                  Icon(Icons.local_hospital, color: Colors.white),
                  'Soins',
                  '4 News '),
            ],
          )
        ],
      ),
    );
  }
}

class DevicesGridDashboard1 extends StatelessWidget {
  const DevicesGridDashboard1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 199, 241, 205)),
            child: Text(
              "Soldes:",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 17, 216, 20)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.all(0),
                  child: FutureBuilder(
                      future: fetchInfo(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text("no data"));
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text("Something went wrong"));
                        }

                        return Center(
                          child: Container(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  LinearProgressIndicator(
                                    backgroundColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.red),
                                    value: 50,
                                  ),
                                  Text('${(50 * 100).round()}%'),
                                ],
                              )),
                        );
                      })),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: FutureBuilder(
                      future: fetchInfo(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text("no data"));
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text("Something went wrong"));
                        }

                        return Center(
                          child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(
                                    strokeWidth: 10,
                                    backgroundColor: Colors.yellow,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.red),
                                    value: 10,
                                  ),
                                  Text(
                                    'Il vous reste ${(10).round()}% de votre solde d'
                                    'autorisation',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ],
                              )),
                        );
                      })),
            ],
          ),
        ],
      ),
    );
  }
}

CardField(
  Size size,
  Color color,
  Icon icon,
  String title,
  String subtitle,
) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Card(
        child: SizedBox(
            height: size.height * .1,
            width: size.width * .39,
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color,
                  child: icon,
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ))),
  );
}
