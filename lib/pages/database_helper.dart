import 'package:application/pages/ModelsTable.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Future<Database> get database async {
    databaseFactory = databaseFactoryFfi;
    return openDatabase(
      join(await getDatabasesPath(), 'university.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Universite(id INTEGER PRIMARY KEY, nom TEXT, adresse TEXT)",
        );
        await db.execute(
          "CREATE TABLE Filiere(id INTEGER PRIMARY KEY, nom TEXT, fraisInscription TEXT)",
        );
        await db.execute(
          "CREATE TABLE FiliereUniversite(id INTEGER PRIMARY KEY, id_filiere INTEGER, id_universite INTEGER)",
        );
        await db.execute(
          "CREATE TABLE Diplome(id INTEGER PRIMARY KEY, nom TEXT)",
        );
        await db.execute(
          "CREATE TABLE DiplomeFiliere(id INTEGER PRIMARY KEY, id_diplome INTEGER, id_filiere INTEGER)",
        );
        await db.execute(
          "CREATE TABLE DiplomesFinCycle(id INTEGER PRIMARY KEY, nom TEXT, id_option INTEGER)",
        );
        await db.execute(
          "CREATE TABLE Debouche(id INTEGER PRIMARY KEY, nom TEXT, id_filiere INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUniversite(Universite universite) async {
    final db = await database;
    await db.insert(
      'Universite',
      universite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertFiliere(Filiere filiere) async {
    final db = await database;
    await db.insert(
      'Filiere',
      filiere.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //debut de la recupération des données des tables
  static Future<List<Universite>> getAllUniversites() async {
    final db = await database;
    final List<Map<String, dynamic>> universiteMaps =
        await db.query('Universite');
    return List.generate(universiteMaps.length, (i) {
      return Universite(
        id: universiteMaps[i]['id'],
        nom: universiteMaps[i]['nom'],
        adresse: universiteMaps[i]['adresse'],
      );
    });
  }

  static Future<List<Filiere>> getAllFilieres() async {
    final db = await database;
    final List<Map<String, dynamic>> filiereMaps = await db.query('Filiere');
    return List.generate(filiereMaps.length, (i) {
      return Filiere(
        id: filiereMaps[i]['id'],
        nom: filiereMaps[i]['nom'],
        fraisInscription: filiereMaps[i]['fraisInscription'],
      );
    });
  }

  static Future<List<Diplome>> getAllDiplomes() async {
    final db = await database;
    final List<Map<String, dynamic>> diplomeMaps = await db.query('Diplome');
    return List.generate(diplomeMaps.length, (i) {
      return Diplome(
        id: diplomeMaps[i]['id'],
        nom: diplomeMaps[i]['nom'],
      );
    });
  }

  static Future<List<DiplomeFiliere>> getAllDiplomesFiliere() async {
    final db = await database;
    final List<Map<String, dynamic>> diplomeFiliereMaps =
        await db.query('DiplomeFiliere');
    return List.generate(diplomeFiliereMaps.length, (i) {
      return DiplomeFiliere(
        id: diplomeFiliereMaps[i]['id'],
        idDiplome: diplomeFiliereMaps[i]['id_diplome'],
        idFiliere: diplomeFiliereMaps[i]['id_filiere'],
      );
    });
  }

  static Future<List<DiplomesFinCycle>> getAllDiplomesFinCycle() async {
    final db = await database;
    final List<Map<String, dynamic>> diplomeFinCycleMaps =
        await db.query('DiplomesFinCycle');
    return List.generate(diplomeFinCycleMaps.length, (i) {
      return DiplomesFinCycle(
        id: diplomeFinCycleMaps[i]['id'],
        nom: diplomeFinCycleMaps[i]['nom'],
        idOption: diplomeFinCycleMaps[i]['id_option'],
      );
    });
  }

  static Future<List<Debouche>> getAllDebouches() async {
    final db = await database;
    final List<Map<String, dynamic>> deboucheMaps = await db.query('Debouche');
    return List.generate(deboucheMaps.length, (i) {
      return Debouche(
        id: deboucheMaps[i]['id'],
        nom: deboucheMaps[i]['nom'],
        idFiliere: deboucheMaps[i]['id_filiere'],
      );
    });
  }
  //debut de la recupération des données des tables
}
