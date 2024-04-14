// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:async';

import 'package:application/pages/ModelsTable.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Future<Database> get database async {
    databaseFactory = databaseFactoryFfi;
    return openDatabase(join(await getDatabasesPath(), 'university.db'),
        onCreate: (db, version) async {
          await db.execute(
            //creation de la table qui va contenir les universités
            "CREATE TABLE Universite(id INTEGER PRIMARY KEY, nom TEXT, adresse TEXT)",
          );
          await db.execute(
            //creation de la table qui va contenir les filières
            "CREATE TABLE Filiere(id INTEGER PRIMARY KEY, nom TEXT, fraisInscription TEXT)",
          ); //table de jointure des Universités et des filières
          await db.execute('''
            CREATE TABLE FiliereOption (
      id INTEGER PRIMARY KEY,
      id_filiere INTEGER,
      id_option INTEGER,
      FOREIGN KEY (id_filiere) REFERENCES Filieres(id),
      FOREIGN KEY (id_option) REFERENCES Options(id)
  )
''');
          await db.execute('''
      CREATE TABLE Options (
        id INTEGER PRIMARY KEY,
        name TEXT,
        anneeDeOption TEXT
      )
    ''');

          await db.execute(
            // la creation de la table qui contenir des differents diplômes en fonction des series
            "CREATE TABLE Diplome(id INTEGER PRIMARY KEY, nom TEXT)",
          );
          await db.execute(
            //table de jointure des serie et filière
            "CREATE TABLE DiplomeFiliere(id INTEGER PRIMARY KEY, id_diplome INTEGER, id_filiere INTEGER)",
          );
          await db.execute(
            // table de diplôme de fin de cycle
            "CREATE TABLE DiplomesFinCycle(id INTEGER PRIMARY KEY, nom TEXT, id_option INTEGER)",
          );
          await db.execute(
            //table de debouché de chaque filière
            "CREATE TABLE Debouche(id INTEGER PRIMARY KEY, nom TEXT, id_filiere INTEGER)",
          );
        },
        version: 2, // Assurez-vous que la version est correctement définie
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            // Si la version précédente était inférieure à 2, ajoutez la colonne imagePath à la table Universite
            await db
                .execute("ALTER TABLE Universite ADD COLUMN imagePath TEXT");
          }
        });
  }

  // static Future<void> insertUniversite(Universite universite) async {
  //   final db = await database;
  //   await db.insert(
  //     'Universite',
  //     universite.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  static Future<void> insertListOfUniversites(
      List<Universite> universites) async {
    final db = await database;
    Batch batch = db.batch();
    for (Universite universite in universites) {
      batch.insert(
        'Universite',
        universite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    print('Toutes les universités ont été insérées avec succès!');
  }

  static Future<int> insertListOfFiliere(List<Filiere> filieres) async {
    final db = await database;
    Batch batch = db.batch();
    for (Filiere filiere in filieres) {
      batch.insert(
        'Filiere',
        filiere.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final List<dynamic> result = await batch.commit();
    final int insertedCount = result.length;
    // ignore: avoid_print
    print('$insertedCount filières ont été insérées avec succès!');
    return insertedCount;
  }

//insertion d'une liste de données
  static Future<void> insertListOfDiplomes(List<String> diplomes) async {
    final db = await database;
    Batch batch = db.batch();
    for (String nomDiplome in diplomes) {
      batch.insert(
        'Diplome',
        {'nom': nomDiplome},
      );
    }
    await batch.commit();
    print('Tous les diplômes ont été insérés avec succès!');
  }

//insertion d'une liste de debouchées
  static Future<void> insertListOfDebouches(
      List<Map<String, dynamic>> debouches) async {
    final db = await database;
    Batch batch = db.batch();
    for (var debouche in debouches) {
      batch.insert(
        'Debouche',
        debouche,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    print(
        'Toutes les données ont été insérées dans la table Debouche avec succès!');
  }

  static Future<void> linkUniversiteToFiliere(
      int idUniversite, int idFiliere) async {
    final db = await database;
    await db.insert(
      'UniversiteFiliere',
      {'id_universite': idUniversite, 'id_filiere': idFiliere},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertListOfUniversiteFilieres(
      List<Map<String, dynamic>> universiteFilieres) async {
    final db = await database;
    Batch batch = db.batch();
    for (var liaison in universiteFilieres) {
      batch.insert(
        'UniversiteFiliere',
        liaison,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    print(
        'Toutes les liaisons entre universités et filières ont été insérées avec succès!');
  }

  static Future<void> linkDiplomeToFiliere(int idDiplome, int idFiliere) async {
    final db = await database;
    await db.insert(
      'DiplomeFiliere',
      {'id_diplome': idDiplome, 'id_filiere': idFiliere},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Insérer des données dans la table de liaison DiplomesFinCycle
  static Future<void> linkOptionToDiplomeFinCycle(
      int idOption, int idDiplomeFinCycle) async {
    final db = await database;
    await db.insert(
      'DiplomesFinCycle',
      {'id_option': idOption, 'id_diplome': idDiplomeFinCycle},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insérer des données dans la table de liaison Debouche
  static Future<void> linkDeboucheToFiliere(
      int idDebouche, int idFiliere) async {
    final db = await database;
    await db.insert(
      'Debouche',
      {'id': idDebouche, 'id_filiere': idFiliere},
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
          imagePath: universiteMaps[i]['imagePath']);
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

  // recuperation des filière en fonction des universités
  static Future<List<Filiere>> getFilieresByUniversite(int universiteId) async {
    final db = await database;
    final List<Map<String, dynamic>> filiereMaps = await db.rawQuery('''
    SELECT Filiere.*
    FROM Filiere
    INNER JOIN FiliereUniversite ON Filiere.id = FiliereUniversite.id_filiere
    WHERE FiliereUniversite.id_universite = ?
  ''', [universiteId]);
    return List.generate(filiereMaps.length, (i) {
      return Filiere(
        id: filiereMaps[i]['id'],
        nom: filiereMaps[i]['nom'],
        fraisInscription: filiereMaps[i]['fraisInscription'],
      );
    });
  }

  //debut de la recupération des données des tables

  // Des Mise à jours
  static Future<void> updateAllUniversites(List<Universite> universites) async {
    final db = await database;
    for (Universite universite in universites) {
      await db.update(
        'Universite',
        universite.toMap(),
        where: 'id = ?',
        whereArgs: [universite.id],
      );
    }
    print('Toutes les universités ont été mises à jour avec succès!');
  }
}
