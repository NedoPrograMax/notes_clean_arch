import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_clean_arch/core/database/database.dart';

import 'package:notes_clean_arch/core/database/notes_db.dart';
import 'package:notes_clean_arch/features/note/data/datasources/local_data_source.dart';
import 'package:notes_clean_arch/features/note/data/repositories/note_repository_impl.dart';
import 'package:notes_clean_arch/features/note/domain/repositories/note_repository.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_add_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_delete_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_edit_note.dart';
import 'package:notes_clean_arch/features/note/domain/usecases/usecase_get_all_notes.dart';
import 'package:notes_clean_arch/features/note/presentation/bloc/note_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Note
  //Bloc
  sl.registerFactory(
    () => NoteBloc(
      useCaseAddNote: sl(),
      useCaseEditNote: sl(),
      useCaseDeleteNote: sl(),
      useCaseGetAllNotes: sl(),
    ),
  );
  //Use Cases
  sl.registerLazySingleton(() => UseCaseAddNote(repository: sl()));
  sl.registerLazySingleton(() => UseCaseEditNote(repository: sl()));
  sl.registerLazySingleton(() => UseCaseDeleteNote(repository: sl()));
  sl.registerLazySingleton(() => UseCaseGetAllNotes(repository: sl()));
  //Repository
  sl.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(localDataSource: sl()));
  //Data Sources
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(notesDb: sl()));
  //DB
  sl.registerLazySingleton<NotesDb>(() => NotesDbFloor(noteDao: sl()));

  final migration1to2 = Migration(1, 2, (database) async {
    await database.execute('ALTER TABLE NoteModel ADD COLUMN color INT');
   
  });

  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .addMigrations([migration1to2]).build();

  sl.registerLazySingleton(() => database.noteDao);
  //! Core

  //! External
}
