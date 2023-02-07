
import 'package:get_it/get_it.dart';
import 'package:noteapp/data/data_source/notes_local_data_source.dart';
import 'package:noteapp/domain/usecases/add_note.dart';
import 'package:noteapp/domain/usecases/delete_note.dart';
import 'package:noteapp/domain/usecases/get_notes.dart';
import 'package:noteapp/domain/usecases/update_note.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_bloc.dart';

import '../../data/data_repository/note_repository.dart';
import '../../domain/repository/base_note_repository.dart';
import '../../presentation/blocs/dark_mode_bloc/dark_mode_block.dart';

final serviceLocator = GetIt.instance;

class ServicesLocator {

  init(){

    serviceLocator.registerFactory(
            () =>NoteBloc(
                serviceLocator(),
                serviceLocator(),
                serviceLocator(),
                serviceLocator())
    );
    serviceLocator.registerFactory(
            () => DarkModeBloc());

    serviceLocator.registerLazySingleton(
            () => AddNoteUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton(
            () => GetNotesUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton(
            () => UpdateNoteUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton(
            () => DeleteNoteUsecase(serviceLocator()));


    serviceLocator.registerLazySingleton<BaseNoteRepository>(
            () => NoteRepository(serviceLocator()));


    serviceLocator.registerLazySingleton<BaseNotesLocalDataSource>(
            () => LocalNotesDataSource());
  }
}
