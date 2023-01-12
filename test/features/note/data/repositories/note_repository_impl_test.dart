import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/error/exception.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/features/note/data/datasources/local_data_source.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';
import 'package:notes_clean_arch/features/note/data/repositories/note_repository_impl.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

class FakeNote extends Fake implements Note {}

void main() {
  late MockLocalDataSource mockLocalDataSource;
  late NoteRepositoryImpl noteRepository;

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    noteRepository = NoteRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  final tNote = Note(
    title: "title",
    text: "text",
    date: DateTime.parse("2023-01-10 12:32:53.007883"),
    id: 1,
     color: Color(12),
  );

  const tNoteModel = NoteModel(
    title: "title",
    text: "text",
    date: "2023-01-10 12:32:53.007883",
    id: 1,
     color: 12,
  );

  const tId = 1;

  group("addNote", () {
    test("should call the datasource with correct data", () async {
      //arrange
      when(() => mockLocalDataSource.addNote(any()))
          .thenAnswer((_) async => const Right(null));
      //act
      noteRepository.addNote(tNote);
      //assert
      verify(() => mockLocalDataSource.addNote(tNote));
    });

    test("should return void when received data succesfully", () async {
      //arrange
      when(() => mockLocalDataSource.addNote(any()))
          .thenAnswer((_) async => const Right(null));
      //act
      final result = await noteRepository.addNote(tNote);
      //assert
      expect(result, const Right(null));
    });

    test("should return [LocalFailure] when cought [LocalException]", () async {
      //arrange
      when(() => mockLocalDataSource.addNote(any()))
          .thenThrow(LocalException());
      //act
      final result = await noteRepository.addNote(tNote);
      //assert
      expect(result, Left(LocalFailure()));
    });
  });

  group("editNote", () {
    test("should call the datasource with correct data", () async {
      //arrange
      when(() => mockLocalDataSource.editNote(any()))
          .thenAnswer((_) async => const Right(null));
      //act
      noteRepository.editNote(tNote);
      //assert
      verify(() => mockLocalDataSource.editNote(tNote));
    });

    test("should return void when received data succesfully", () async {
      //arrange
      when(() => mockLocalDataSource.editNote(any()))
          .thenAnswer((_) async => const Right(null));
      //act
      final result = await noteRepository.editNote(tNote);
      //assert
      expect(result, const Right(null));
    });

    test("should return [LocalFailure] when cought [LocalException]", () async {
      //arrange
      when(() => mockLocalDataSource.editNote(any()))
          .thenThrow(LocalException());
      //act
      final result = await noteRepository.editNote(tNote);
      //assert
      expect(result, Left(LocalFailure()));
    });
  });

  group("deleteNote", () {
    test("should call the datasource with correct data", () async {
      //arrange
      when(() => mockLocalDataSource.deleteNoteById(any()))
          .thenAnswer((_) async => const Right(null));
      //act
      noteRepository.deleteNoteById(tId);
      //assert
      verify(() => mockLocalDataSource.deleteNoteById(tId));
    });

    test("should return void when received data succesfully", () async {
      //arrange
      when(() => mockLocalDataSource.deleteNoteById(any()))
          .thenAnswer((_) async => const Right(null));
      //act
      final result = await noteRepository.deleteNoteById(tId);
      //assert
      expect(result, const Right(null));
    });

    test("should return [LocalFailure] when cought [LocalException]", () async {
      //arrange
      when(() => mockLocalDataSource.deleteNoteById(any()))
          .thenThrow(LocalException());
      //act
      final result = await noteRepository.deleteNoteById(tId);
      //assert
      expect(result, Left(LocalFailure()));
    });
  });

  group("getAllNotes", () {
    test("should call the datasource", () async {
      //arrange
      when(() => mockLocalDataSource.getAllNotes())
          .thenAnswer((invocation) async => [tNoteModel]);
      //act
      await noteRepository.getAllNotes();
      //assert
      verify(() => mockLocalDataSource.getAllNotes());
    });

    test("should convert data and return it when there are no errors",
        () async {
      //arrange
      when(() => mockLocalDataSource.getAllNotes())
          .thenAnswer((invocation) async => [tNoteModel]);
      //act
      final result = await noteRepository.getAllNotes();
      late Note midNote;
      result.fold((l) => null, (r) {
        midNote = r.first;
      });
      //assert
      expect(midNote, tNote);
    });

    test("should return [LocalFailure] when cauhgt [LocalException]", () async {
      //arrange
      when(() => mockLocalDataSource.getAllNotes()).thenThrow(LocalException());
      //act
      final result = await noteRepository.getAllNotes();
      //assert
      expect(result, Left(LocalFailure()));
    });
  });
}
