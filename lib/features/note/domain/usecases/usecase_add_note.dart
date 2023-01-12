import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UseCaseAddNote implements UseCase<void, UseCaseAddNoteParams> {
  final NoteRepository repository;
  UseCaseAddNote({required this.repository});

  @override
  Future<Either<Failure, void>> call({required UseCaseAddNoteParams params}) {
    return repository.addNote(params.note);
  }
}

class UseCaseAddNoteParams extends Equatable {
  final Note note;
  const UseCaseAddNoteParams({required this.note});

  @override
  List<Object?> get props => [note];
}
