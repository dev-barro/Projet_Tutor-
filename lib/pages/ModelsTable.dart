// ignore_for_file: file_names

class Universite {
  final int id;
  final String nom;
  final String adresse;
  //le constructeur qui permettra d'initialiser Universite
  Universite({required this.id, required this.nom, required this.adresse});
  // la methode qui permet de mapper les données de la classe
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'adresse': adresse,
    };
  }
}

//model Filiere//
class Filiere {
  final int id;
  final String nom;
  final String fraisInscription;
  

  Filiere({required this.id, required this.nom,required this.fraisInscription});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
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
}
