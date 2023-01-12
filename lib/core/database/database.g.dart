// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteModel` (`title` TEXT NOT NULL, `text` TEXT NOT NULL, `date` TEXT NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `color` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteModelInsertionAdapter = InsertionAdapter(
            database,
            'NoteModel',
            (NoteModel item) => <String, Object?>{
                  'title': item.title,
                  'text': item.text,
                  'date': item.date,
                  'id': item.id,
                  'color': item.color
                }),
        _noteModelUpdateAdapter = UpdateAdapter(
            database,
            'NoteModel',
            ['id'],
            (NoteModel item) => <String, Object?>{
                  'title': item.title,
                  'text': item.text,
                  'date': item.date,
                  'id': item.id,
                  'color': item.color
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteModel> _noteModelInsertionAdapter;

  final UpdateAdapter<NoteModel> _noteModelUpdateAdapter;

  @override
  Future<List<NoteModel>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM NoteModel',
        mapper: (Map<String, Object?> row) => NoteModel(
            title: row['title'] as String,
            text: row['text'] as String,
            date: row['date'] as String,
            id: row['id'] as int?,
            color: row['color'] as int?));
  }

  @override
  Future<void> deleteNoteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM NoteModel WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> addNote(NoteModel note) async {
    await _noteModelInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> editNote(NoteModel note) async {
    await _noteModelUpdateAdapter.update(note, OnConflictStrategy.replace);
  }
}
