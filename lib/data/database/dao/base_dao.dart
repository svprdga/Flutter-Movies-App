import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/database/entity/movie_db_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDao {
  static const databaseVersion = 1;

  static const _databaseName = 'com.my.app.db';

  static const moviesTableName = 'movies';

  Database? _database;

  @protected
  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createMoviesTableV1(batch);
        await batch.commit();
      },
      version: databaseVersion,
    );
  }

  void _createMoviesTableV1(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE $moviesTableName(
      ${MovieDbEntity.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${MovieDbEntity.fieldMovieId} TEXT NOT NULL,
      ${MovieDbEntity.fieldTitle} TEXT NOT NULL,
      ${MovieDbEntity.fieldImageUrl} TEXT NULL,
      ${MovieDbEntity.fieldReleaseDate} INTEGER NOT NULL
      );
      ''',
    );
  }
}
