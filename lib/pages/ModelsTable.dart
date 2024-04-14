class Universite {
  final int id;
  final String nom;
  final String adresse;
  final String imagePath;
  //le constructeur qui permettra d'initialiser Universite
  Universite(
      {required this.id,
      required this.nom,
      required this.adresse,
      required this.imagePath});
  // la methode qui permet de mapper les données de la classe
  Map<String, dynamic> toMap() {
    return {'id': id, 'nom': nom, 'adresse': adresse, 'imagePath': imagePath};
  }

  factory Universite.fromMap(Map<String, dynamic> map) {
    return Universite(
      id: map['id'],
      nom: map['nom'],
      adresse: map['adresse'],
      imagePath: map['imagePath'],
    );
  }
}

//model Filiere//
class Filiere {
  final int id;
  final String nom;
  final String fraisInscription;

  Filiere(
      {required this.id, required this.nom, required this.fraisInscription});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
  }

  factory Filiere.fromMap(Map<String, dynamic> map) {
    return Filiere(
      id: map['id'],
      nom: map['nom'],
      fraisInscription: map['fraisInscription'],
    );
  }
}

// model de jointure entre université et filière
class FiliereUniversite {
  final int id;
  final int idFiliere;
  final int idUniversite;

  FiliereUniversite(
      {required this.id, required this.idFiliere, required this.idUniversite});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_filiere': idFiliere,
      'id_universite': idUniversite,
    };
  }
}

class Diplome {
  final int id;
  final String nom;

  Diplome({required this.id, required this.nom});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
  }

  factory Diplome.fromMap(Map<String, dynamic> map) {
    return Diplome(
      id: map['id'],
      nom: map['nom'],
    );
  }
}

// la classe de jointure entre diplôme et filières
class DiplomeFiliere {
  final int id;
  final int idDiplome;
  final int idFiliere;

  DiplomeFiliere(
      {required this.id, required this.idDiplome, required this.idFiliere});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_diplome': idDiplome,
      'id_filiere': idFiliere,
    };
  }
}

class DiplomesFinCycle {
  final int id;
  final String nom;
  final int idOption;

  DiplomesFinCycle(
      {required this.id, required this.nom, required this.idOption});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'id_option': idOption,
    };
  }

  factory DiplomesFinCycle.fromMap(Map<String, dynamic> map) {
    return DiplomesFinCycle(
      id: map['id'],
      nom: map['nom'],
      idOption: map['id_option'],
    );
  }
}

class Debouche {
  final int id;
  final String nom;
  final int idFiliere;

  Debouche({required this.id, required this.nom, required this.idFiliere});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'id_filiere': idFiliere,
    };
  }

  factory Debouche.fromMap(Map<String, dynamic> map) {
    return Debouche(
      id: map['id'],
      nom: map['nom'],
      idFiliere: map['id_filiere'],
    );
  }
}

class Options {
  final int id;
  final String name;
  final String anneeDeOption;

  Options({
    required this.id,
    required this.name,
    required this.anneeDeOption,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'anneeDeOption': anneeDeOption,
    };
  }

  factory Options.fromMap(Map<String, dynamic> map) {
    return Options(
      id: map['id'],
      name: map['name'],
      anneeDeOption: map['anneeDeOption'],
    );
  }
}

class FiliereOptions {
  final int id;
  final int idFiliere;
  final int idOption;

  FiliereOptions({
    required this.id,
    required this.idFiliere,
    required this.idOption,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idFiliere': idFiliere,
      'idOption': idOption,
    };
  }

  factory FiliereOptions.fromMap(Map<String, dynamic> map) {
    return FiliereOptions(
      id: map['id'],
      idFiliere: map['idFiliere'],
      idOption: map['idOption'],
    );
  }
}
