import 'package:application/pages/ModelsTable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

enum DatabaseState {
  initializing,
  initialized,
  failed,
}

class UniversityDataBase {
  UniversityDataBase._();
  static UniversityDataBase instance = UniversityDataBase._();
  late Database database;
  DatabaseState _databaseState = DatabaseState.initializing;

  factory UniversityDataBase() {
    instance = UniversityDataBase._();
    instance.initDB();
    return instance;
  }

  Future<void> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    try {
      database = await openDatabase(
        join(await getDatabasesPath(), 'university.db'),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE University(name TEXT PRIMARY KEY, type TEXT, ville TEXT)");
        },
        version: 1,
      );
      _databaseState = DatabaseState.initialized;
    } catch (e) {
      _databaseState = DatabaseState.failed;
      if (kDebugMode) {
        print('Failed to initialize database: $e');
      }
    }
  }

  Future<void> insertUniversity(University university) async {
    await _ensureDatabaseInitialized();
    final Database db = database;
    await db.insert('University', university.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUniversity(University university) async {
    await _ensureDatabaseInitialized();
    final Database db = database;
    await db.update(
      'University',
      university.toMap(),
      where: 'name = ?',
      whereArgs: [university.name],
    );
  }

  Future<void> deleteUniversity(String name) async {
    await _ensureDatabaseInitialized();
    final Database db = database;
    await db.delete("University", where: 'name = ?', whereArgs: [name]);
  }

  Future<List<University>> getAllUniversities() async {
    await _ensureDatabaseInitialized();
    final Database db = database;
    final List<Map<String, dynamic>> maps = await db.query('University');
    return List.generate(maps.length, (i) {
      return University(
        name: maps[i]['name'],
        type: maps[i]['type'],
        ville: maps[i]['ville'],
      );
    });
  }

  final List<University> defaultUniversity = [
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
    University(
        name: "Université Norbert Zongo", ville: "koudougou", type: "public"),
  ];

  Future<void> _ensureDatabaseInitialized() async {
    if (_databaseState == DatabaseState.initialized) {
      return;
    } else if (_databaseState == DatabaseState.initializing) {
      await Future.delayed(const Duration(milliseconds: 10));
      return _ensureDatabaseInitialized();
    } else if (_databaseState == DatabaseState.failed) {
      throw Exception('Database initialization failed');
    } else {
      throw Exception('Unknown database state');
    }
  }
}
