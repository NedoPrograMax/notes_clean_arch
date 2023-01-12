import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_clean_arch/features/note/presentation/bloc/note_bloc.dart';
import 'package:notes_clean_arch/features/note/presentation/pages/note_edit_page.dart';
import 'features/note/presentation/pages/note_list_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          // primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          hoverColor: Colors.amber,
          appBarTheme: AppBarTheme(color: Colors.blue.shade900),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
              backgroundColor: Colors.blue.shade900)),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => sl()..add(NoteEventListPage()),
      child: BlocConsumer<NoteBloc, NoteState>(
        builder: (ctx, state) {
          if (state is NoteStateList) {
            return NoteListPage(state.notes);
          }
          if (state is NoteStateEdit) {
            return NoteEditPage(state.note);
          }
          return const Text("Shouldn't happen....I guess");
        },
        listener: (context, state) {},
      ),
    );
  }
}
