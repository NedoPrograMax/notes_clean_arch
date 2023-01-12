import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/domain/repositories/note_repository.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_delete_note.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  late MockNoteRepository mockNoteRepository;
  late UseCaseDeleteNote useCaseDeleteNote;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCaseDeleteNote = UseCaseDeleteNote(repository: mockNoteRepository);
  });

  const tId = 1;

  final Future<Either<Failure, void>> tFutureVoid =
      Future.value(const Right(null));

  test("should call repository's method with the correct data", () async {
//arrange
    when(() => mockNoteRepository.deleteNoteById(any()))
        .thenAnswer((_) => tFutureVoid);
//act
    useCaseDeleteNote(params: const UseCaseDeleteNoteParams(id: tId));
//assert
    verify(() => mockNoteRepository.deleteNoteById(1));
  });

  test("should return the same object from repository", () async {
    //arrange
    when(() => mockNoteRepository.deleteNoteById(any()))
        .thenAnswer((_) => tFutureVoid);
    //act
    final result =
        useCaseDeleteNote(params: const UseCaseDeleteNoteParams(id: tId));
    //assert
    expect(result, tFutureVoid);
  });
}
