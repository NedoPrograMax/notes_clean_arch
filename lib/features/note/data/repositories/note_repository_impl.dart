import 'dart:ui';

import 'package:notes_clean_arch/core/error/exception.dart';
import 'package:notes_clean_arch/features/note/data/datasources/local_data_source.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_clean_arch/features/note/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final LocalDataSource localDataSource;
  NoteRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, void>> addNote(Note note) async {
    try {
      await localDataSource.addNote(note);
      return const Right(null);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNoteById(int id) async {
    try {
      await localDataSource.deleteNoteById(id);
      return const Right(null);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editNote(Note note) async {
    try {
      await localDataSource.editNote(note);
      return const Right(null);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try{
    final noteModels = await localDataSource.getAllNotes();
    final notes = noteModels
        .map(
          (noteModel) => noteModel.toNote(),
        )
        .toList();
    return Right(notes);
    } on LocalException{
      return Left(LocalFailure());
    }
  }
}

