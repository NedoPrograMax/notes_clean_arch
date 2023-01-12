import 'dart:async';
import 'package:floor/floor.dart';
import 'package:notes_clean_arch/core/database/note_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../features/note/data/models/note_model.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [NoteModel])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
