import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<List<dynamic>?> fetchInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var obtainedEmail = sharedPreferences.getString('matricule');

    var response = await http
        .get(Uri.parse('http://192.168.1.5:8080/user/$obtainedEmail'));
    var nom = jsonDecode(response.body)['nom'];
    var prenom = jsonDecode(response.body)['prenom'];
    var email = jsonDecode(response.body)['email'];
    var matricule = jsonDecode(response.body)['matricule'];
    var mdp = jsonDecode(response.body)['mdp'];
    var mobile = jsonDecode(response.body)['mobile'];
    var addresse = jsonDecode(response.body)['address'];
    var fcmtoken = json.decode(response.body)['fcmtoken'];
    var solde_autorisation = jsonDecode(response.body)['solde_autorisation'];
    List userdetails = [];
    userdetails.add(nom);
    userdetails.add(prenom);
    userdetails.add(email);
    userdetails.add(matricule);
    userdetails.add(mobile);
    userdetails.add(addresse);
    userdetails.add(fcmtoken);
    userdetails.add(mdp);
    userdetails.add(solde_autorisation);

    return userdetails;
  }
}
