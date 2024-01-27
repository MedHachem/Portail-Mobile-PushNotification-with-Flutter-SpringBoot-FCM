// ignore_for_file: require_trailing_commas

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'notification_details.dart';

/// Listens for incoming foreground messages and displays them in a list.
class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 199, 206, 241)),
        child: Text(
          'No notifications received',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 17, 70, 216)),
        ),
      );
    }
    Color getCorrectColor(String cat) {
      if (cat == "Soins") {
        return Color.fromARGB(255, 201, 241, 199);
      }
      if (cat == "Absences") {
        return Color.fromARGB(255, 199, 206, 241);
      }
      if (cat == "WorkDay") {
        return Color.fromARGB(255, 241, 236, 189);
      }
      if (cat == "Demandes scolaires et jardins d'enfants") {
        return Color.fromARGB(255, 239, 207, 192);
      }
      return Color.fromARGB(255, 219, 206, 243);
    }

    Color getCorrectColorText(String cat) {
      if (cat == "Soins") {
        return Color.fromARGB(255, 34, 222, 56);
      }
      if (cat == "Absences") {
        return Color.fromARGB(255, 17, 70, 216);
      }
      if (cat == "WorkDay") {
        return Color.fromARGB(255, 214, 197, 38);
      }
      if (cat == "Demandes scolaires et jardins d'enfants") {
        return Color.fromARGB(255, 229, 104, 46);
      }
      return Color.fromARGB(255, 103, 41, 209);
    }

    Icon getCorrectIcon(String cat) {
      if (cat == "Soins") {
        return Icon(
          Icons.medical_information,
          color: Color.fromARGB(255, 255, 255, 255),
        );
      }
      if (cat == "Workday") {
        return Icon(
          Icons.laptop,
          color: Color.fromARGB(255, 255, 255, 255),
        );
      }
      if (cat == "Absences") {
        return Icon(
          Icons.lock_clock,
          color: Color.fromARGB(255, 255, 255, 255),
        );
      }
      return Icon(
        Icons.notification_important,
        color: Color.fromARGB(255, 255, 255, 255),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        RemoteMessage message = _messages[index];

        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 246, 246, 246),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Row(children: [
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: getCorrectColor(
                                message.data['categorie'].toString())),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                              child: getCorrectIcon(
                                  message.data['categorie'].toString())),
                        )),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(message.notification?.title ?? 'N/D',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: getCorrectColor(
                                    message.data['categorie'].toString()),
                              ),
                              child: Text(
                                message.data['categorie'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: getCorrectColorText(
                                      message.data['categorie'].toString()),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                              height: 6,
                            ),
                            Text(message.notification?.body ?? 'N/D',
                                style: TextStyle(color: Colors.grey[500])),
                          ]),
                    )
                  ]),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 236, 232, 232)),
                          child: Text(
                            message.sentTime.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 36, 36, 36),
                                fontSize: 8),
                          ),
                        )
                      ],
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 143, 160, 247)),
                        child: TextButton(
                          child: Text(
                            "Voir plus",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, '/message',
                              arguments: MessageArguments(message, false)),
                        ))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
