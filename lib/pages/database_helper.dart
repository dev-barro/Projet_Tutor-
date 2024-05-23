import 'dart:async';
import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Future<Database> get database async {
      databaseFactory = databaseFactoryFfi;
    return openDatabase(
      join(await getDatabasesPath(), 'LaBase.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Création de la table IES
    await db.execute('''
      CREATE TABLE IES (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        type TEXT NOT NULL,
        siteWeb TEXT,
        adrMail TEXT,
        ville TEXT NOT NULL,
        bp TEXT,
        tel TEXT
      )
    ''');

    // Création de la table Filiere
    await db.execute('''
      CREATE TABLE Filiere (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        matieresDominantes TEXT NOT NULL,
        matieresImportantesDeLaterminale TEXT NOT NULL,
        conditionsParticulieres TEXT NOT NULL,
        ufrId INTEGER NOT NULL,
        iesId INTEGER NOT NULL,
        infoComplementaire TEXT,
        coutDeLaFormation TEXT,
        FOREIGN KEY (ufrId) REFERENCES UFR(id),
        FOREIGN KEY (iesId) REFERENCES IES(id)
      )
    ''');

    // Création de la table UFR
    await db.execute('''
      CREATE TABLE UFR(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        iesId INTEGER NOT NULL,
        FOREIGN KEY (iesId) REFERENCES IES(id)
      )
    ''');

    // Création de la table Options
    await db.execute('''
      CREATE TABLE Options (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        anneeDeOption TEXT,
        filiereId INTEGER NOT NULL,
        FOREIGN KEY (filiereId) REFERENCES Filiere(id)
      )
    ''');

    // Création de la table Debouche
    await db.execute('''
      CREATE TABLE Debouche (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        filiereId INTEGER NOT NULL,
        optionId INTEGER,
        FOREIGN KEY (filiereId) REFERENCES Filiere(id),
        FOREIGN KEY (optionId) REFERENCES Options(id)
      )
    ''');

    // Création de la table Serie
    await db.execute('''
      CREATE TABLE Serie (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL
      )
    ''');

    // Création de la table SerieFiliere
    await db.execute('''
      CREATE TABLE SerieFiliere (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filiereId INTEGER NOT NULL,
        serieId INTEGER NOT NULL,
        FOREIGN KEY (filiereId) REFERENCES Filiere(id),
        FOREIGN KEY (serieId) REFERENCES Serie(id)
      )
    ''');
  }

  // La méthode d'insertion des IES
  static Future<void> insertIES(IES ies) async {
    final db = await database;
    await db.insert(
      'IES',
      ies.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La méthode d'insertion des UFR
  static Future<void> insertUFR(UFR ufr) async {
    final db = await database;
    await db.insert(
      'UFR',
      ufr.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La méthode d'insertion des Filieres
  static Future<void> insertFiliere(Filiere filiere) async {
    final db = await database;
    await db.insert(
      'Filiere',
      filiere.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La méthode d'insertion des Options
  static Future<void> insertOptions(Options option) async {
    final db = await database;
    await db.insert(
      'Options',
      option.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La méthode d'insertion des Debouches
  static Future<void> insertDebouche(Debouche debouche) async {
    final db = await database;
    await db.insert(
      'Debouche',
      debouche.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La méthode d'insertion des Series
  static Future<void> insertSerie(Serie serie) async {
    final db = await database;
    await db.insert(
      'Serie',
      serie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // La méthode d'insertion des SerieFiliere
  static Future<void> insertSerieFiliere(SerieFiliere serieFiliere) async {
    final db = await database;
    await db.insert(
      'SerieFiliere',
      serieFiliere.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getTablesList() async {
    final db = await database;
    return await db
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
  }

  static Future<List<Map<String, dynamic>>> getIES() async {
    final db = await database;
    return await db.query('IES');
  }

  static Future<List<IES>> getAllIES() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('IES');

    // Convertir la liste de Map en liste d'objets IES
    return List.generate(maps.length, (i) {
      return IES(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        type: maps[i]['type'],
        siteWeb: maps[i]['siteWeb'],
        adrMail: maps[i]['adrMail'],
        ville: maps[i]['ville'],
        bp: maps[i]['bp'],
        tel: maps[i]['tel'],
        // Ajoutez les autres champs si nécessaire
      );
    });
  }

  static Future<List<Map<String, dynamic>>> getUFR() async {
    final db = await database;
    final List<Map<String, dynamic>> ufrList = await db.query('UFR');
    return ufrList.isEmpty ? [] : ufrList;
  }

  // Méthode pour récupérer toutes les filières de la base de données
  static Future<List<Filiere>> getAllFilieres() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Filiere');

    // Convertir la liste de Map en liste d'objets Filiere
    return List.generate(maps.length, (i) {
      return Filiere(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        matieresDominantes: maps[i]['matieresDominantes'],
        matieresImportantesDeLaterminale: maps[i]
            ['matieresImportantesDeLaterminale'],
        conditionsParticulieres: maps[i]['conditionsParticulieres'],
        iesId: maps[i]['iesId'],
        ufrId: maps[i]['ufrId'],
        infoComplementaire: maps[i]['infoComplementaire'],
        coutDeLaFormation: maps[i]['coutDeLaFormation'],
      );
    });
  }

  static Future<List<Options>> getOptions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Options');

    // Convertir la liste de Map en liste d'objets Options
    return List.generate(maps.length, (i) {
      return Options(
        id: maps[i]['id'],
        name: maps[i]['name'],
        anneeDeOption: maps[i]['anneeDeOption'],
        filiereId: maps[i]['filiereId'],
      );
    });
  }

  static Future<List<Serie>> getSerie() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Serie');
    return List.generate(maps.length, (i) {
      return Serie(id: maps[i]['id'], nom: maps[i]['nom']);
    });
  }
}
