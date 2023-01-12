import 'dart:ui';

import 'package:equatable/equatable.dart';
import "package:flutter/foundation.dart" show immutable;

import '../../data/models/note_model.dart';

@immutable
class Note extends Equatable {
  final String title;
  final String text;
  final DateTime date;
  final int? id;
  final Color color;

  const Note({
    required this.title,
    required this.text,
    required this.date,
    required this.id,
    required this.color,
  });

  @override
  List<Object?> get props => [
        title,
        text,
        date,
        id,
        color,
      ];
}

extension NoteToNoteModel on Note {
  NoteModel toNoteModel() => NoteModel(
        title: title,
        text: text,
        date: date.toIso8601String(),
        id: this.id,
        color: color.value,
      );
}

