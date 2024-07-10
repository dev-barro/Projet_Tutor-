/* Models des universités */
class Universite {
  String id;
  String nom;
  String? adresse;
  String? ville;
  String? siteWeb;
  String? boitePostale;
  String type; // Type déclaré comme non nullable

  Universite({
    required this.id,
    required this.nom,
    this.adresse,
    this.ville,
    this.siteWeb,
    this.boitePostale,
    required this.type,
  });

  factory Universite.fromMap(Map<String, dynamic> data, String documentId) {
    return Universite(
      id: documentId,
      nom: data['nom'] ?? '',
      adresse: data['adresse'],
      ville: data['ville'],
      siteWeb: data['siteWeb'],
      boitePostale: data['boitePostale'],
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'adresse': adresse,
      'ville': ville,
      'siteWeb': siteWeb,
      'boitePostale': boitePostale,
      'type': type,
    };
  }
}

/* Models des ufrs */

class UFR {
  String id;
  String nom;

  UFR({
    required this.id,
    required this.nom,
  });

  factory UFR.fromMap(Map<String, dynamic> data, String documentId) {
    return UFR(
      id: documentId,
      nom: data['nom'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
    };
  }
}
/* Models des filiere */

class Filiere {
  String id;
  String nom;
  String? matieresDominantes;
  String? matieresImportantesDeLaTle;
  String? accessibilite;
  String? informationComplementaire;
  String? contrainte;

  Filiere({
    required this.id,
    required this.nom,
    this.matieresDominantes,
    this.matieresImportantesDeLaTle,
    this.accessibilite,
    this.informationComplementaire,
    this.contrainte,
  });

  factory Filiere.fromMap(Map<String, dynamic> data, String documentId) {
    return Filiere(
      id: documentId,
      nom: data['nom'] ?? '',
      matieresDominantes: data['matieresDominantes'] ?? '',
      matieresImportantesDeLaTle: data['matieresImportantesDeLaTle'] ?? '',
      accessibilite: data['accessibilite'] ?? '',
      informationComplementaire: data['informationComplementaire'] ?? '',
      contrainte: data['contrainte'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'matieresDominantes': matieresDominantes,
      'matieresImportantesDeLaTle': matieresImportantesDeLaTle,
      'accessibilite': accessibilite,
      'informationComplementaire': informationComplementaire,
      'contrainte': contrainte,
    };
  }
}

/* Models des Option */

class Option {
  String id;
  String nom;
  String? description;

  Option({required this.id, required this.nom, this.description});

  factory Option.fromMap(Map<String, dynamic> data, String documentId) {
    return Option(
      id: documentId,
      nom: data['nom'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'description': description,
    };
  }
}

/* Models des Debouchés */
class Debouche {
  String id;
  String nom;
  String? description;

  Debouche({required this.id, required this.nom, this.description});

  factory Debouche.fromMap(Map<String, dynamic> data, String documentId) {
    return Debouche(
      id: documentId,
      nom: data['nom'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'description': description,
    };
  }
}
/* Models des NiveauSortie */

class Serie {
  String id;
  String nom;
  String? description;
  String? moyenne;

  Serie({
    required this.id,
    required this.nom,
  });

  factory Serie.fromMap(Map<String, dynamic> data, String documentId) {
    return Serie(
      id: documentId,
      nom: data['nom'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
    };
  }
}

class FILIERE {
  String id;
  String nom;
  String nomDeUniversite;
  String nomDeUfr;
  String? matieresDominantes;
  String? matieresImportantesDeLaTle;
  String? accessibilite;
  String? informationComplementaire;
  String? NiveauDeSortie;
  String? contrainte;
  List<String> Serie;
  List<String> Option;
  List<String> debouche;

  FILIERE({
    required this.id,
    required this.nom,
    required this.nomDeUniversite,
    required this.nomDeUfr,
    this.matieresDominantes,
    this.matieresImportantesDeLaTle,
    this.accessibilite,
    this.informationComplementaire,
    this.contrainte,
    required this.Option,
    required this.Serie,
    required this.debouche,
    this.NiveauDeSortie,
  });

  factory FILIERE.fromMap(Map<String, dynamic> data, String documentId) {
    return FILIERE(
      id: documentId,
      nom: data['nom'] ?? '',
      nomDeUniversite: data['nomDeUniversite'] ?? '',
      nomDeUfr: data['nomDeUfr'] ?? '',
      matieresImportantesDeLaTle: data['matieresImportantesDeLaTle'],
      matieresDominantes: data['matieresDominantes'],
      accessibilite: data['accessibilite'],
      informationComplementaire: data['informationComplementaire'],
      Option: List<String>.from(data['Option'] ?? []),
      Serie: List<String>.from(data['Serie'] ?? []),
      debouche: List<String>.from(data['debouche'] ?? []),
      NiveauDeSortie: data['NiveauDeSortie'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'nomDeUniversite': nomDeUniversite,
      'nomDeUfr': nomDeUfr,
      'matieresDominantes': matieresDominantes,
      'matieresImportantesDeLaTle': matieresImportantesDeLaTle,
      'accessibilite': accessibilite,
      'informationComplementaire': informationComplementaire,
      'NiveauDeSortie': NiveauDeSortie,
      'contrainte': contrainte,
      'Option': Option,
      'Serie': Serie,
      'debouche': debouche,
    };
  }
}
