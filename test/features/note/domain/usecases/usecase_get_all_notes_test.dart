import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/core/usecase/usecase.dart';
import 'package:notes_clean_arch/features/note/data/models/note_model.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/domain/repositories/note_repository.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_add_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_get_all_notes.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

class FakeNote extends Fake implements Note {}

void main() {
  late MockNoteRepository mockNoteRepository;
  late UseCaseGetAllNotes useCaseGetAllNotes;

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCaseGetAllNotes = UseCaseGetAllNotes(repository: mockNoteRepository);
  });

  final tList = [
    Note(
      title: "title",
      text: "text",
      date: DateTime.now(),
      id: 1,
       color: Color(12),
    ),
  ];

  final Future<Either<Failure, List<Note>>> tFutureNotes = Future.value(
    Right(
      [
        Note(
          title: "title",
          text: "text",
          date: DateTime.now(),
          id: 1,
           color: Color(12),
        ),
      ],
    ),
  );

  test("should call repository's method with the correct data", () async {
//arrange
    when(() => mockNoteRepository.getAllNotes())
        .thenAnswer((_) => tFutureNotes);
//act
    useCaseGetAllNotes(params: NoParams());
//assert
    verify(() => mockNoteRepository.getAllNotes());
  });

  test("should sort the list from repository when success", () async {
    //arrange
    when(() => mockNoteRepository.getAllNotes())
        .thenAnswer((_) => tFutureNotes);
    //act
    final result = await useCaseGetAllNotes(params: NoParams());
    //assert
    result.fold((failure) => expect("This shouldn't", "happen"), (list) {
      final sortedList = tList..sort(
        (a, b) => b.date.compareTo(a.date),
      );
      return expect(list.areEqual(sortedList), true);
    });
   
  });
}

extension AreNotesListsEqual on List<Note> {
  bool areEqual(List<Note> other) {
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
