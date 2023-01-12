import 'package:dartz/dartz.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';

import '../../../../core/error/failure.dart';

abstract class NoteRepository {
  Future<Either<Failure, void>> addNote(Note note);

  Future<Either<Failure, void>> editNote(Note note);

  Future<Either<Failure, void>> deleteNoteById(int id);

  Future<Either<Failure, List<Note>>> getAllNotes();
}
