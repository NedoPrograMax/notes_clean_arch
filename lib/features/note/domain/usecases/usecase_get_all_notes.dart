import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UseCaseGetAllNotes implements UseCase<void, NoParams> {
  final NoteRepository repository;
  UseCaseGetAllNotes({required this.repository});

  @override
  Future<Either<Failure, List<Note>>> call({required NoParams params}) {
    return repository.getAllNotes().then((either) {
      return either.fold(
          (failure) => Left(failure),
          (list) => Right(list
            ..sort(
              (a, b) => b.date.compareTo(a.date),
            )));
    });
  }
}
