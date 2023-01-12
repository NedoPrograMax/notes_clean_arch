import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/domain/repositories/note_repository.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_edit_note.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

class FakeNote extends Fake implements Note {}

void main() {
  late MockNoteRepository mockNoteRepository;
  late UseCaseEditNote useCaseEditNote;

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCaseEditNote = UseCaseEditNote(repository: mockNoteRepository);
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
    when(() => mockNoteRepository.editNote(any()))
        .thenAnswer((_) => tFutureVoid);
//act
    useCaseEditNote(params: UseCaseEditNoteParams(note: tNote));
//assert
    verify(() => mockNoteRepository.editNote(tNote));
  });

  test("should return the same object from repository", () async {
    //arrange
    when(() => mockNoteRepository.editNote(any()))
        .thenAnswer((_) => tFutureVoid);
    //act
    final result = useCaseEditNote(params: UseCaseEditNoteParams(note: tNote));
    //assert
    expect(result, tFutureVoid);
  });
}
