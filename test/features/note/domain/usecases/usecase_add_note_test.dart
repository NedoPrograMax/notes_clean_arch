import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/domain/repositories/note_repository.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_add_note.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

class FakeNote extends Fake implements Note {}

void main() {
  late MockNoteRepository mockNoteRepository;
  late UseCaseAddNote useCaseAddNote;

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCaseAddNote = UseCaseAddNote(repository: mockNoteRepository);
  });

  final tNote = Note(
    title: "title",
    text: "text",
    date: DateTime.now(),
    id: 1,
     color: Color(12),
  );

  final Future<Either<Failure, void>> tFutureVoid =
      Future.value(const Right(null));

  test("should call repository's method with the correct data", () async {
//arrange
    when(() => mockNoteRepository.addNote(any()))
        .thenAnswer((_) => tFutureVoid);
//act
    useCaseAddNote(params: UseCaseAddNoteParams(note: tNote));
//assert
    verify(() => mockNoteRepository.addNote(tNote));
  });

  test("should return the same object from repository", () async {
    //arrange
    when(() => mockNoteRepository.addNote(any()))
        .thenAnswer((_) => tFutureVoid);
    //act
    final result =
         useCaseAddNote(params: UseCaseAddNoteParams(note: tNote));
    //assert
    expect(result, tFutureVoid);
  });
}
