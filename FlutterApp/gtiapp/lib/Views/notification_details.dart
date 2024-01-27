// ignore_for_file: require_trailing_commas

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Message route arguments.
class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication);
}

/// Displays information about a [RemoteMessage].
class MessageView extends StatelessWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageArguments args =
        ModalRoute.of(context)!.settings.arguments! as MessageArguments;
    RemoteMessage message = args.message;
    RemoteNotification? notification = message.notification;
    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromARGB(255, 111, 140, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_sharp,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 111, 140, 255),
        title: const Text("Notification details:"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
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
                                  image:
                                      AssetImage('assets/images/GTILOGO.png'))),
                        )),
                    Positioned(
                        child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Center(
                        child: Text(
                          message.notification?.title ?? 'N/D',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: [
                    if (notification != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 201, 222, 223)),
                        child: Card(
                          child: Center(
                            child: viewData(
                              '[' + message.data["objet"] + ']',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 201, 222, 223)),
                        child: Card(
                          child: Center(
                            child: viewData(
                              message.data["type"],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            img(
                              message.data['image'],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Card(
                          child: Center(
                            child:
                                viewDataBody(notification.body, 'Message:  '),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 235, 235, 229)),
                        child: Card(
                          elevation: 4.0,
                          child: Center(
                            child: viewDataBody(
                                message.sentTime?.toString(), "Publié le:  "),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: makeBottom,
    );
  }

  /// A single data row.
  Widget viewData(String? value) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 0, 0, 91)),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewDataBody(String? value, String title) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 63, 114, 107)),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
            ),
          ),
        ],
      ),
    );
  }

  Widget img(String? value) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 244, 243, 236)),
      child: Card(
        elevation: 4.0,
        child: Center(
          child: Image.network(
            value ??
                'https://img.icons8.com/bubbles/2x/appointment-reminders.png',
            height: 150,
            width: 100,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget appbar(String? value) {
    return Text(
      value ?? 'N/A',
      style: const TextStyle(fontSize: 16),
    );
  }
}
