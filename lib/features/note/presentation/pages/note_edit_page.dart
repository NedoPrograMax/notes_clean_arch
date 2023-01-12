import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:notes_clean_arch/features/note/domain/entities/note.dart';
import 'package:notes_clean_arch/features/note/presentation/bloc/note_bloc.dart';
import 'package:notes_clean_arch/features/note/presentation/widgets/color_row_picker.dart';

class NoteEditPage extends StatefulWidget {
  NoteEditPage(this.note, {super.key});
  // Note object received from db
  final Note? note;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
// Map of TextFormFields values
  final _inputValues = {
    "title": "",
    "text": "",
  };

  @override
  void initState() {
    _inputValues["title"] = widget.note?.title ?? "";
    _inputValues["text"] = widget.note?.text ?? "";
    _cardColor = widget.note?.color ?? Colors.white;
    super.initState();
  }

  final _form = GlobalKey<FormState>();

  Color _cardColor = Colors.green;

  void _submit(BuildContext context) {
    _form.currentState?.save();
    if (widget.note?.id == null) {
      context.read<NoteBloc>().add(NoteEventAdd(
              note: Note(
            title: _inputValues["title"] ?? "",
            text: _inputValues["text"] ?? "",
            date: DateTime.now(),
            id: widget.note?.id,
            color: _cardColor,
          )));
    } else {
      context.read<NoteBloc>().add(NoteEventEdit(
              note: Note(
            title: _inputValues["title"] ?? "",
            text: _inputValues["text"] ?? "",
            date: DateTime.now(),
            id: widget.note!.id,
            color: _cardColor,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: AnimatedContainer(
              padding: const EdgeInsets.all(12.0),
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _cardColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _inputValues["title"],
                      decoration:
                          const InputDecoration(labelText: "Enter your title"),
                      onSaved: (newValue) =>
                          _inputValues["title"] = newValue ?? "",
                    ),
                    SingleChildScrollView(
                      child: TextFormField(
                        initialValue: _inputValues["text"],
                        decoration:
                            const InputDecoration(labelText: "Enter your text"),
                        onSaved: (newValue) =>
                            _inputValues["text"] = newValue ?? "",
                        maxLines: 6,
                        minLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ColorRowPicker(
            pickColor: (color) {
              setState(() {
                _cardColor = color;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () => _submit(context),
      ),
    );
  }
}
