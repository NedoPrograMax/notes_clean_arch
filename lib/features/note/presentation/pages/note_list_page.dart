import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/presentation/bloc/note_bloc.dart';

import '../widgets/note_dismissible_list_item.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage(this.notes, {super.key});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (ctx, index) {
          final note = notes[index];
          return NoteDismissibleListItem(
            note: note,
            key: ValueKey(note.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            context.read<NoteBloc>().add(const NoteEventEditPage(note: null)),
      ),
    );
  }
}
