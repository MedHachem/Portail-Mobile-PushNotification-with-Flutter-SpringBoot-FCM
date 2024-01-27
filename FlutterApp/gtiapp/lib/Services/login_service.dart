import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gtiapp/Services/AuthentifcationService.dart';
import 'package:http/http.dart' as http;

class Service {
  //create the method to save user
  AuthService auth = AuthService();
  Future<http.Response> saveUser(
      String matricule, String mdp, String Token) async {
    try {
      //create uri
      Uri uri = Uri.parse("http://192.168.1.5:8080/Connexion");
      //header
      Map<String, String> headers = {"Content-Type": "application/json"};
      //body
      Map data = {
        'matricule': '$matricule',
        'mdp': '$mdp',
        'fcmtoken': '$Token',
      };
      var body = json.encode(data);
      var response = await http.post(uri, headers: headers, body: body);

      //returns the successful user data json object
      return response;
    } on DioError catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<double> checkIfUserexist(String mat) async {
    var response =
        await http.get(Uri.parse('http://192.168.1.5:8080/CheckUser/$mat'));
    if (response.statusCode == 200) {
      print("mawjoud");
      return 1;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("mch mawjoud jawek behi");
      return 0;
    }
  }
}
