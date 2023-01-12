import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/core/usecase/usecase.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_add_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_delete_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_edit_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_get_all_notes.dart';
import 'package:notes_clean_arch/features/note/presentation/bloc/note_bloc.dart';

import '../../data/datasources/local_data_source_test.dart';

class MockUseCaseAddNote extends Mock implements UseCaseAddNote {}

class MockUseCaseEditNote extends Mock implements UseCaseEditNote {}

class MockUseCaseDeleteNote extends Mock implements UseCaseDeleteNote {}

class MockUseCaseGetAllNotes extends Mock implements UseCaseGetAllNotes {}

void main() {
  late MockUseCaseAddNote mockUseCaseAddNote;
  late MockUseCaseEditNote mockUseCaseEditNote;
  late MockUseCaseDeleteNote mockUseCaseDeleteNote;
  late MockUseCaseGetAllNotes mockUseCaseGetAllNotes;
  late NoteBloc noteBloc;

  setUp(() {
    mockUseCaseAddNote = MockUseCaseAddNote();
    mockUseCaseEditNote = MockUseCaseEditNote();
    mockUseCaseDeleteNote = MockUseCaseDeleteNote();
    mockUseCaseGetAllNotes = MockUseCaseGetAllNotes();
    noteBloc = NoteBloc(
      useCaseAddNote: mockUseCaseAddNote,
      useCaseEditNote: mockUseCaseEditNote,
      useCaseDeleteNote: mockUseCaseDeleteNote,
      useCaseGetAllNotes: mockUseCaseGetAllNotes,
    );
  });

  final tNote = Note(
    title: "title",
    text: "text",
    date: DateTime.parse("2023-01-10 12:32:53.007883"),
    id: null,
     color: Color(12),
  );

  group("NoteEventListPage", () {
    test("should emit NoteStateList when success", () async {
      //arrange
      when(() => mockUseCaseGetAllNotes(params: NoParams()))
          .thenAnswer((_) async => const Right([]));
      //assert later
      expect(noteBloc.stream, emitsInOrder([const NoteStateList(notes: [])]));
      //act
      noteBloc.add(NoteEventListPage());
    });

    test("should emit NoteStateError when [LocalFailure]]", () async {
      //arrange
      when(() => mockUseCaseGetAllNotes(params: NoParams()))
          .thenAnswer((_) async => Left(LocalFailure()));
      //assert later
      expect(noteBloc.stream,
          emitsInOrder([const NoteStateError(message: LocalFailure.message)]));
      //act
      noteBloc.add(NoteEventListPage());
    });
  });

  group("NoteEventEditPage", () {
    test("should emit NoteStateEdit with the same data", () async {
      //arrange
      //assert later
      expect(noteBloc.stream, emitsInOrder([NoteStateEdit(note: tNote)]));
      //act
      noteBloc.add(NoteEventEditPage(note: tNote));
    });
  });

  group("NoteEventEdit", () {
    test("should emit NoteStateList when success", () async {
      //arrange
      when(() => mockUseCaseGetAllNotes(params: NoParams()))
          .thenAnswer((_) async => Right([tNote]));
      when(() =>
              mockUseCaseEditNote(params: UseCaseEditNoteParams(note: tNote)))
          .thenAnswer((_) async => const Right(null));
      //assert later
      expect(
          noteBloc.stream,
          emitsInOrder([
            NoteStateList(notes: [tNote])
          ]));
      //act
      noteBloc.add(NoteEventEdit(note: tNote));
    });

    test("should emit NoteStateError when [LocalFailure]]", () async {
      //arrange
      when(() =>
              mockUseCaseEditNote(params: UseCaseEditNoteParams(note: tNote)))
          .thenAnswer((_) async => Left(LocalFailure()));
      //assert later
      expect(noteBloc.stream,
          emitsInOrder([const NoteStateError(message: LocalFailure.message)]));
      //act
      noteBloc.add(NoteEventEdit(note: tNote));
    });
  });

  group("NoteEventAdd", () {
    test("should emit NoteStateList when success", () async {
      //arrange
      when(() => mockUseCaseGetAllNotes(params: NoParams()))
          .thenAnswer((_) async => Right([tNote]));
      when(() => mockUseCaseAddNote(params: UseCaseAddNoteParams(note: tNote)))
          .thenAnswer((_) async => const Right(null));
      //assert later
      expect(
          noteBloc.stream,
          emitsInOrder([
            NoteStateList(notes: [tNote])
          ]));
      //act
      noteBloc.add(NoteEventAdd(note: tNote));
    });

    test("should emit NoteStateError when [LocalFailure]]", () async {
      //arrange
      when(() => mockUseCaseAddNote(params: UseCaseAddNoteParams(note: tNote)))
          .thenAnswer((_) async => Left(LocalFailure()));
      //assert later
      expect(noteBloc.stream,
          emitsInOrder([const NoteStateError(message: LocalFailure.message)]));
      //act
      noteBloc.add(NoteEventAdd(note: tNote));
    });
  });

  group("NoteEventDelete", () {
    test("should emit NoteStateList when success", () async {
      //arrange
      when(() => mockUseCaseGetAllNotes(params: NoParams()))
          .thenAnswer((_) async => const Right([]));
      when(() => mockUseCaseDeleteNote(
              params: const UseCaseDeleteNoteParams(id: tId)))
          .thenAnswer((_) async => const Right(null));
      //assert later
      expect(noteBloc.stream, emitsInOrder([const NoteStateList(notes: [])]));
      //act
      noteBloc.add(const NoteEventDelete(id: tId));
    });

    test("should emit NoteStateError when [LocalFailure]]", () async {
      //arrange
      when(() => mockUseCaseDeleteNote(
              params: const UseCaseDeleteNoteParams(id: tId)))
          .thenAnswer((_) async => Left(LocalFailure()));
      //assert later
      expect(noteBloc.stream,
          emitsInOrder([const NoteStateError(message: LocalFailure.message)]));
      //act
      noteBloc.add(const NoteEventDelete(id: tId));
    });
  });
}
