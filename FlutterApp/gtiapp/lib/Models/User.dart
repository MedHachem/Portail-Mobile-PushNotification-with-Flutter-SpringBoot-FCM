class User {
  final num id;
  final String matricule;
  final String nom;
  final String prenom;
  final String email;
  final String mdp;
  final String mobile;
  final String address;
  final num solde_conge;
  final num solde_autorisation;
  final String fcmtoken;
  const User({
    required this.id,
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.address,
    required this.mobile,
    required this.mdp,
    required this.fcmtoken,
    required this.solde_autorisation,
    required this.solde_conge,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      nom: jsonData['nom'],
      prenom: jsonData['prenom'],
      solde_autorisation: jsonData['solde_autorisation'],
      matricule: jsonData['matricule'],
      mobile: jsonData['mobile'],
      fcmtoken: jsonData['fcmtoken'],
      solde_conge: jsonData['solde_congé'],
      mdp: jsonData['mdp'],
      email: jsonData['email'],
      address: jsonData['adress'],
    );
  }
}
