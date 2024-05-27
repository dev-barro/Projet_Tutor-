class IES {
  late int id;
  late String nom;
  late String type;
  String? siteWeb; // Déclaré comme optionnel avec le signe de question
  String? adrMail; // Déclaré comme optionnel avec le signe de question
  late String ville;
  String? bp; // Déclaré comme optionnel avec le signe de question
  String? tel; // Déclaré comme optionnel avec le signe de question

  // Constructeur
  IES(
      {required this.id,
      required this.nom,
      required this.type,
      this.siteWeb, // Paramètre nommé optionnel
      this.adrMail, // Paramètre nommé optionnel
      required this.ville,
      this.bp, // Paramètre nommé optionnel
      this.tel // Paramètre nommé optionnel
      });

  // Méthode pour convertir un map en instance de IES
  factory IES.fromMap(Map<String, dynamic> map) {
    return IES(
        id: map['id'],
        nom: map['nom'],
        type: map['type'],
        siteWeb: map['siteWeb'],
        adrMail: map['adrMail'],
        ville: map['ville'],
        bp: map['bp'],
        tel: map['tel']);
  }

  // Méthode pour convertir une instance de IES en map
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'type': type,
      'siteWeb': siteWeb,
      'adrMail': adrMail,
      'ville': ville,
      'bp': bp,
      'tel': tel
    };
  }
}

class UFR {
  late int id;
  late String nom;
  late int iesId;

  UFR({required this.id, required this.nom, required this.iesId});
  Map<String, dynamic> toMap() {
    return {'nom': nom, 'iesId': iesId};
  }

  factory UFR.fromMap(Map<String, dynamic> map) {
    return UFR(id: map['id'], nom: map['nom'], iesId: map['iesId']);
  }
}

//model Filiere//
class Filiere {
  late int id;
  late String nom;
  late String matieresDominantes;
  late String matieresImportantesDeLaterminale;
  late String conditionsParticulieres;
  late int ufrId;
  late int iesId;
  String? infoComplementaire;
  String? coutDeLaFormation;
  Filiere(
      {required this.id,
      required this.nom,
      required this.matieresDominantes,
      this.coutDeLaFormation,
      required this.matieresImportantesDeLaterminale,
      required this.conditionsParticulieres,
      this.infoComplementaire,
      this.ufrId = 0,
      this.iesId = 0});

  factory Filiere.fromMap(Map<String, dynamic> map) {
    return Filiere(
        id: map['id'],
        nom: map['nom'],
        matieresDominantes: map['matieresDominantes'],
        coutDeLaFormation: map['coutDeLaFormation'],
        matieresImportantesDeLaterminale:
            map['matieresImportantesDeLaterminale'],
        conditionsParticulieres: map['conditionsParticulieres'],
        infoComplementaire: map['infoComplementaire'],
        ufrId: map['ufrId'],
        iesId: map['iesId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'matieresDominantes': matieresDominantes,
      'coutDeLaFormation': coutDeLaFormation,
      'matieresImportantesDeLaterminale': matieresImportantesDeLaterminale,
      'conditionsParticulieres': conditionsParticulieres,
      'infoComplementaire': infoComplementaire,
      'ufrId': ufrId,
      'iesId': iesId
    };
  }
}

class Options {
  late int id;
  late String name;
  late String? anneeDeOption;
  late int filiereId;

  Options(
      {required this.id,
      required this.name,
      this.anneeDeOption,
      required this.filiereId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'anneeDeOption': anneeDeOption,
      'filiereId': filiereId
    };
  }

  factory Options.fromMap(Map<String, dynamic> map) {
    return Options(
        id: map['id'],
        name: map['name'],
        anneeDeOption: map['anneeDeOption'],
        filiereId: map['filiereId']);
  }
}

class Debouche {
  late int id;
  late String description;
  late int filiereId;
  late int? optionId;

  Debouche(
      {required this.id,
      required this.description,
      required this.filiereId,
      this.optionId});

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'filiereId': filiereId,
      'optionId': optionId
    };
  }

  factory Debouche.fromMap(Map<String, dynamic> map) {
    return Debouche(
        id: map['id'],
        description: map['description'],
        filiereId: map['filiereId'],
        optionId: map['optionId']);
  }
}

class Serie {
  late int id;
  late String nom;
  Serie({required this.id, required this.nom});

  Map<String, dynamic> toMap() {
    return {'nom': nom};
  }

  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(id: map['id'], nom: map['nom']);
  }
}

class SerieFiliere {
  late int id;
  late int filiereId;
  late int serieId;
  SerieFiliere(
      {required this.id, required this.filiereId, required this.serieId});
  Map<String, dynamic> toMap() {
    return {'filiereId': filiereId, 'serieId': serieId};
  }

  factory SerieFiliere.fromMap(Map<String, dynamic> map) {
    return SerieFiliere(
        id: map['id'], serieId: map['serieId'], filiereId: map['filiereId']);
  }
}
