import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/note_repository.dart';

class UseCaseDeleteNote implements UseCase<void, UseCaseDeleteNoteParams> {
  final NoteRepository repository;
  UseCaseDeleteNote({required this.repository});

  @override
  Future<Either<Failure, void>> call({required UseCaseDeleteNoteParams params}) {
    return repository.deleteNoteById(params.id);
  }
}

class UseCaseDeleteNoteParams extends Equatable {
  final int id;
  const UseCaseDeleteNoteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
