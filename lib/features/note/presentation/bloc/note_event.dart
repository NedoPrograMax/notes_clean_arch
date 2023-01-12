part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteEventListPage extends NoteEvent {}

class NoteEventEditPage extends NoteEvent {
  final Note? note;
  const NoteEventEditPage({required this.note});

  @override
  List<Object> get props => [note ?? 1];
}

class NoteEventEdit extends NoteEvent {
  final Note note;
  const NoteEventEdit({required this.note});

  @override
  List<Object> get props => [note];
}

class NoteEventAdd extends NoteEvent {
  final Note note;
  const NoteEventAdd({required this.note});

  @override
  List<Object> get props => [note];
}

class NoteEventDelete extends NoteEvent {
  final int id;
  const NoteEventDelete({required this.id});

  @override
  List<Object> get props => [id];
}
