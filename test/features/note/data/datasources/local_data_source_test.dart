import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/database/notes_db.dart';
import 'package:notes_clean_arch/core/error/exception.dart';
import 'package:notes_clean_arch/features/note/data/datasources/local_data_source.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';

class MockNotesDb extends Mock implements NotesDb {}

class FakeNoteModel extends Fake implements NoteModel {}

final tVoidFuture = Future.value(null);
const tId = 1;
final tNoteModel = NoteModel(
  title: "title",
  text: "text",
  date: DateTime.parse("2023-01-10 12:32:53.007883").toIso8601String(),
  id: null,
   color: 12,
);

final tNote = Note(
  title: "title",
  text: "text",
  date: DateTime.parse("2023-01-10 12:32:53.007883"),
  id: null,
   color: Color(12),
);

const tNoteModelList = [
  NoteModel(
    title: "title",
    text: "text",
    date: "2023-01-10 12:32:53.007883",
    id: null,
     color: 12,
  ),
];

final tNoteModelListFuture = Future.value(
  const [
    NoteModel(
      title: "title",
      text: "text",
      date: "2023-01-10 12:32:53.007883",
      id: null,
       color: 12,
    ),
  ],
);

void main() {
  late MockNotesDb mockNotesDb;
  late LocalDataSourceImpl localDataSource;

  setUpAll(() {
    registerFallbackValue(FakeNoteModel());
  });

  setUp(() {
    mockNotesDb = MockNotesDb();
    localDataSource = LocalDataSourceImpl(notesDb: mockNotesDb);
  });

  group("AddNote", () {
    test("should call notesDb with proper data", () async {
      //arrange
      when(() => mockNotesDb.addNote(any())).thenAnswer((_) => tVoidFuture);
      //act
      await localDataSource.addNote(tNote);
      //assert
      verify(() => mockNotesDb.addNote(tNoteModel));
    });

    test("should throw the [LocalExeption] when there are some errors",
        () async {
      //arrange
      when(() => mockNotesDb.addNote(any())).thenThrow(Exception());
      //act
      final call = localDataSource.addNote;
      //assert
      expect(call(tNote), throwsA(const TypeMatcher<LocalException>()));
    });
  });

  group("EditNote", () {
    test("should call notesDb with proper data", () async {
      //arrange
      when(() => mockNotesDb.editNote(any())).thenAnswer((_) => tVoidFuture);
      //act
      await localDataSource.editNote(tNote);
      //assert
      verify(() => mockNotesDb.editNote(tNoteModel));
    });

    test("should throw the [LocalExeption] when there are some errors",
        () async {
      //arrange
      when(() => mockNotesDb.editNote(any())).thenThrow(Exception());
      //act
      final call = localDataSource.editNote;
      //assert
      expect(call(tNote), throwsA(const TypeMatcher<LocalException>()));
    });
  });

  group("DeleteNote", () {
    test("should call notesDb with proper data", () async {
      //arrange
      when(() => mockNotesDb.deleteNoteById(any()))
          .thenAnswer((_) => tVoidFuture);
      //act
      await localDataSource.deleteNoteById(tId);
      //assert
      verify(() => mockNotesDb.deleteNoteById(tId));
    });

    test("should throw the [LocalExeption] when there are some errors",
        () async {
      //arrange
      when(() => mockNotesDb.deleteNoteById(any())).thenThrow(Exception());
      //act
      final call = localDataSource.deleteNoteById;
      //assert
      expect(call(tId), throwsA(const TypeMatcher<LocalException>()));
    });
  });

  group("GetAllNotes", () {
    test("should call notesDb with proper data ", () async {
      //arrange
      when(() => mockNotesDb.getAllNotes())
          .thenAnswer((_) => tNoteModelListFuture);
      //act
      final result = localDataSource.getAllNotes();
      //assert
      verify(() => mockNotesDb.getAllNotes());
    });

    test("should return the same object", () async {
      //arrange
      when(() => mockNotesDb.getAllNotes())
          .thenAnswer((_) async => tNoteModelList);
      //act
      final result = await localDataSource.getAllNotes();
      //assert
      final areEqual = result.areEqual(tNoteModelList);
      expect(areEqual, true);
    });

    test("should throw the [LocalExeption] when there are some errors",
        () async {
      //arrange
      when(() => mockNotesDb.getAllNotes()).thenThrow(Exception());
      //act
      final call = localDataSource.getAllNotes;
      //assert
      expect(call(), throwsA(const TypeMatcher<LocalException>()));
    });
  });
}

extension AreNoteModelsListsEqual on List<NoteModel> {
  bool areEqual(List<NoteModel> other) {
    bool areEqual = true;
    for (int i = 0; i < other.length; i++) {
      areEqual = other[i] == this[i];
      if (!areEqual) {
        return areEqual;
      }
    }
    return areEqual;
  }
}
