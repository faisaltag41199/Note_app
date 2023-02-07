import 'package:hive/hive.dart';
import 'package:noteapp/core/error/exception.dart';
import 'package:noteapp/core/error/failure.dart';
import 'package:noteapp/data/models/note_model.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';

import '../../core/local_data_source_helper/hive_database_helper.dart';

abstract class BaseNotesLocalDataSource{

  Future<List<Note>> getNotes();
  Future<void> addNote(note);
  Future<void> updateNote(note);
  Future<void> deleteNote(int noteId);


}

class LocalNotesDataSource implements BaseNotesLocalDataSource{

  @override
  Future<List<Note>> getNotes() async {
    try{
      final Box noteBox=HiveDatabaseHelper.noteBoxInstance!;
      List<Note> notes=noteBox.values.toList().reversed.toList() as List<Note>;
      return notes;

    }catch(exception){
      throw LocalDatabaseException(message: exception.toString());
    }
  }
  @override
  Future<void> addNote(note) async {
    try{
      final Box noteBox=HiveDatabaseHelper.noteBoxInstance!;
       noteBox.put(note.id,note);

    }catch(exception){
      throw LocalDatabaseException(message: exception.toString());
    }
  }

  @override
  Future<void> updateNote(note) async {
    try{
      final Box noteBox=HiveDatabaseHelper.noteBoxInstance!;
      noteBox.put(note.id, note);

    }catch(exception){
      throw LocalDatabaseException(message: exception.toString());
    }
  }

  @override
  Future<void> deleteNote(int noteId) async {
    try{
      final Box noteBox=HiveDatabaseHelper.noteBoxInstance!;
      noteBox.delete(noteId);

    }catch(exception){
      throw LocalDatabaseException(message: exception.toString());
    }
  }



}