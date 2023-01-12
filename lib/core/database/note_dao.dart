import 'package:floor/floor.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM NoteModel')
  Future<List<NoteModel>> getAllNotes();

  @insert
  Future<void> addNote(NoteModel note);

  @Query("DELETE FROM NoteModel WHERE id = :id")
  Future<void> deleteNoteById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> editNote(NoteModel note);
}
