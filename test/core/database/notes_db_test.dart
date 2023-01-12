import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/database/note_dao.dart';
import 'package:notes_clean_arch/core/database/notes_db.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';

class MockNoteDao extends Mock implements NoteDao {}

class FakeNoteModel extends Fake implements NoteModel {}

void main() {
  late MockNoteDao mockNoteDao;
  late NotesDbFloor notesDbFloor;

  setUpAll(() {
    registerFallbackValue(FakeNoteModel());
  });

  setUp(() {
    mockNoteDao = MockNoteDao();
    notesDbFloor = NotesDbFloor(noteDao: mockNoteDao);
  });

  final tVoidFuture = Future.value(null);
  const tId = 1;
  const tNoteModel = NoteModel(
    title: "title",
    text: "text",
    date: "2023-01-10 12:32:53.007883",
    id: tId,
    color: 12,
  );

  final tNoteModelListFuture = Future.value(
    const [
      NoteModel(
        title: "title",
        text: "text",
        date: "2023-01-10 12:32:53.007883",
        id: 1,
        color: 12,
      ),
    ],
  );

  group("addNote", () {
    test(
      "should call dao with proper data",
      () async {
//arrange
        when(() => mockNoteDao.addNote(any()))
            .thenAnswer((invocation) => tVoidFuture);
//act
        await notesDbFloor.addNote(tNoteModel);
//assert
        verify(() => mockNoteDao.addNote(tNoteModel));
      },
    );

    test(
      "should return the same object",
      () async {
//arrange
        when(() => mockNoteDao.addNote(any()))
            .thenAnswer((invocation) => tVoidFuture);
//act
        final result = notesDbFloor.addNote(tNoteModel);
//assert
        expect(result, tVoidFuture);
      },
    );
  });

  group("editNote", () {
    test(
      "should call dao  with proper data",
      () async {
//arrange
        when(() => mockNoteDao.editNote(any()))
            .thenAnswer((invocation) => tVoidFuture);
//act
        await notesDbFloor.editNote(tNoteModel);
//assert
        verify(() => mockNoteDao.editNote(tNoteModel));
      },
    );

    test(
      "should return the same object",
      () async {
//arrange
        when(() => mockNoteDao.editNote(any()))
            .thenAnswer((invocation) => tVoidFuture);
//act
        final result = notesDbFloor.editNote(tNoteModel);
//assert
        expect(result, tVoidFuture);
      },
    );
  });

  group("deleteNote", () {
    test(
      "should call dao  with proper data",
      () async {
//arrange
        when(() => mockNoteDao.deleteNoteById(any()))
            .thenAnswer((invocation) => tVoidFuture);
//act
        await notesDbFloor.deleteNoteById(tId);
//assert
        verify(() => mockNoteDao.deleteNoteById(tId));
      },
    );

    test(
      "should return the same object",
      () async {
//arrange
        when(() => mockNoteDao.deleteNoteById(any()))
            .thenAnswer((invocation) => tVoidFuture);
//act
        final result = notesDbFloor.deleteNoteById(tId);
//assert
        expect(result, tVoidFuture);
      },
    );
  });

  group("getAllNotes", () {
    test(
      "should call dao  with proper data",
      () async {
//arrange
        when(() => mockNoteDao.getAllNotes())
            .thenAnswer((invocation) => tNoteModelListFuture);
//act
        await notesDbFloor.getAllNotes();
//assert
        verify(() => mockNoteDao.getAllNotes());
      },
    );

    test(
      "should return the same object",
      () async {
//arrange
        when(() => mockNoteDao.getAllNotes())
            .thenAnswer((invocation) => tNoteModelListFuture);
//act
        final result = notesDbFloor.getAllNotes();
//assert
        expect(result, tNoteModelListFuture);
      },
    );
  });
}
