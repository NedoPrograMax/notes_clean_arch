import 'package:notes_clean_arch/core/database/note_dao.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';

abstract class NotesDb {
  Future<void> addNote(NoteModel note);

  Future<void> deleteNoteById(int id);

  Future<void> editNote(NoteModel note);

  Future<List<NoteModel>> getAllNotes();
}

class NotesDbFloor implements NotesDb {
  final NoteDao noteDao;
  NotesDbFloor({required this.noteDao});

  @override
  Future<void> addNote(NoteModel note) => noteDao.addNote(note);

  @override
  Future<void> deleteNoteById(int id) => noteDao.deleteNoteById(id);

  @override
  Future<void> editNote(NoteModel note) => noteDao.editNote(note);

  @override
  Future<List<NoteModel>> getAllNotes() => noteDao.getAllNotes();
}
