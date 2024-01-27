import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
              right: 5,
              top: 0,
              width: 80,
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/GTILOGO.png'))),
              )),
          Positioned(
              child: Container(
            margin: EdgeInsets.only(top: 0),
            child: Center(
              child: Text(
                "Notifications list!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
