import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_clean_arch/core/error/failure.dart';
import 'package:notes_clean_arch/core/usecase/usecase.dart';
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_add_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_delete_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_edit_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_get_all_notes.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final UseCaseAddNote useCaseAddNote;
  final UseCaseEditNote useCaseEditNote;
  final UseCaseDeleteNote useCaseDeleteNote;
  final UseCaseGetAllNotes useCaseGetAllNotes;

  NoteBloc({
    required this.useCaseAddNote,
    required this.useCaseEditNote,
    required this.useCaseDeleteNote,
    required this.useCaseGetAllNotes,
  }) : super(const NoteStateList(notes: [])) {
    on<NoteEvent>((event, emit) async {
      if (event is NoteEventEditPage) {
        emit(NoteStateEdit(note: event.note));
      } else if (event is NoteEventListPage) {
        final result = await useCaseGetAllNotes(params: NoParams());
        emit(result.fold(
          (failure) => NoteStateError(message: failure.message),
          (notes) => NoteStateList(notes: notes),
        ));
      } else if (event is NoteEventEdit) {
        final result = await useCaseEditNote(
            params: UseCaseEditNoteParams(note: event.note));
        result.fold(
          (failure) => emit(NoteStateError(message: failure.message)),
          (_) {
            add(NoteEventListPage());
          },
        );
      } else if (event is NoteEventAdd) {
        final result = await useCaseAddNote(
            params: UseCaseAddNoteParams(note: event.note));
        result.fold(
          (failure) => emit(NoteStateError(message: failure.message)),
          (_) {
            add(NoteEventListPage());
          },
        );
      } else if (event is NoteEventDelete) {
        final result = await useCaseDeleteNote(
            params: UseCaseDeleteNoteParams(id: event.id));
        result.fold(
          (failure) => emit(NoteStateError(message: failure.message)),
          (_) {
            add(NoteEventListPage());
          },
        );
      }
    });
  }
}

extension Transmit on Failure {
  String get message {
    if (this is LocalFailure) {
      return LocalFailure.message;
    }
    return "Unknown error";
  }
}
