import 'dart:ui';

import 'package:notes_clean_arch/core/database/note_dao.dart';
import 'package:notes_clean_arch/core/database/notes_db.dart';
import 'package:notes_clean_arch/core/error/exception.dart';

import '../../domain/entities/note.dart';
import '../models/note_model.dart';

abstract class LocalDataSource {
  Future<void> addNote(Note note);

  Future<void> editNote(Note note);

  Future<void> deleteNoteById(int id);

  Future<List<NoteModel>> getAllNotes();
}

class LocalDataSourceImpl implements LocalDataSource {
  final NotesDb notesDb;

  LocalDataSourceImpl({required this.notesDb});

  @override
  Future<void> addNote(Note note) async {
    try {
      notesDb.addNote(note.toNoteModel());
    } catch (e) {
      print(e.toString());
      throw LocalException();
    }
  }

  @override
  Future<void> deleteNoteById(int id) async {
    try {
      notesDb.deleteNoteById(id);
    } catch (e) {
      print(e.toString());
      throw LocalException();
    }
  }

  @override
  Future<void> editNote(Note note) async {
    try {
      notesDb.editNote(note.toNoteModel());
    } catch (e) {
      print(e.toString());
      throw LocalException();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes()  async{
    try {
      final notes = await notesDb.getAllNotes();
      return notes;
    } catch (e) {
      print(e.toString());
      throw LocalException();
    }
  }
}

