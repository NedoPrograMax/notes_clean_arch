import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import 'dismissible_background.dart';
import 'note_list_item.dart';

class NoteDismissibleListItem extends StatefulWidget {
  const NoteDismissibleListItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  State<NoteDismissibleListItem> createState() =>
      _NoteDismissibleListItemState();
}

class _NoteDismissibleListItemState extends State<NoteDismissibleListItem> {
  var _dismissableState = DismissableState.none;

  void _maintainDismissableState(DismissUpdateDetails details) {
    if (details.progress == 0) {
      if (_dismissableState != DismissableState.none) {
        setState(() {
          _dismissableState = DismissableState.none;
        });
      }
    } else if (details.direction == DismissDirection.endToStart) {
      if (_dismissableState != DismissableState.delete) {
        setState(() {
          _dismissableState = DismissableState.delete;
        });
      }
    } else {
      if (_dismissableState != DismissableState.edit) {
        setState(() {
          _dismissableState = DismissableState.edit;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.note.id),
      onUpdate: _maintainDismissableState,
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Deleting"),
                    content: SingleChildScrollView(
                      child: Text(
                        "Are you sure you want to delete \"${widget.note.title}\" note?",
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Confirm")),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Decline")),
                    ],
                  ));
        }
        return Future.value(true);
      },
      background: DismissibleBackground(
          isDeleting: _dismissableState == DismissableState.delete),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context
              .read<NoteBloc>()
              .add(NoteEventDelete(id: widget.note.id ?? 0));
        } else {
          context.read<NoteBloc>().add(NoteEventEditPage(note: widget.note));
        }
      },
      child: NoteListItem(
        title: widget.note.title,
        text: widget.note.text,
        date: widget.note.date,
        borderColor: widget.note.color,
        backgroundColor: _dismissableState.color,
      ),
    );
  }
}

enum DismissableState {
  delete,
  edit,
  none,
}

extension DecideColor on DismissableState {
  Color? get color {
    switch (this) {
      case DismissableState.delete:
        return Colors.red;

      case DismissableState.edit:
        return Colors.green;
      case DismissableState.none:
        return null;
    }
  }
}
