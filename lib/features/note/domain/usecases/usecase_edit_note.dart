import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UseCaseEditNote implements UseCase<void, UseCaseEditNoteParams> {
  final NoteRepository repository;
  UseCaseEditNote({required this.repository});

  @override
  Future<Either<Failure, void>> call({required UseCaseEditNoteParams params}) {
    return repository.editNote(params.note);
  }
}

class UseCaseEditNoteParams extends Equatable {
  final Note note;
  const UseCaseEditNoteParams({required this.note});

  @override
  List<Object?> get props => [note];
}
