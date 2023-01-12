part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteStateList extends NoteState {
  final List<Note> notes;
  const NoteStateList({required this.notes});

  @override
  List<Object> get props => [...notes];
}

class NoteStateEdit extends NoteState {
  final Note? note;
  const NoteStateEdit({required this.note});

  @override
  List<Object> get props => [note ?? 2];
}

class NoteStateLoading extends NoteState {}

class NoteStateError extends NoteState {
  final String message;
  const NoteStateError({required this.message});

  @override
  List<Object> get props => [message];
}
