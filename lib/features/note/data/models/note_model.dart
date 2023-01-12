import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../domain/entities/note.dart';

@immutable
@entity
class NoteModel extends Equatable {
  final String title;
  final String text;
  final String date;
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int? color;

  const NoteModel({
    required this.title,
    required this.text,
    required this.date,
    this.id,
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

extension NoteModelToNote on NoteModel {
  Note toNote() => Note(
        title: title,
        text: text,
        date: DateTime.parse(date),
        id: this.id ?? 1,
        color: Color(color ?? 1),
      );
}

