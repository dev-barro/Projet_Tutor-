
class University {
  String? name;
  String? ville;
  String? type;

//le constructeur de la classe University
  University( {this.name, this.type, this.ville});

// conversion des objet en map  ce qui facilitera l'envoi des données dans
// la base de données
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ville': ville,
      'type': type,
    };
  }

  // la conversion des données recuperer de la base de données en instance
  factory University.fromMap(Map<String, dynamic> map) => University(
        name: map['name'],
        ville: map['ville'],
        type: map['type'],
      );
}
