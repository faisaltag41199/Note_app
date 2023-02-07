
import 'package:dartz/dartz.dart';
import 'package:noteapp/core/error/exception.dart';
import 'package:noteapp/core/error/failure.dart';
import 'package:noteapp/data/models/note_model.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';
import 'package:noteapp/domain/repository/base_note_repository.dart';

import '../data_source/notes_local_data_source.dart';

class NoteRepository implements BaseNoteRepository{

  final BaseNotesLocalDataSource baseNotesLocalDataSource;
  NoteRepository(this.baseNotesLocalDataSource);

  @override
  Future<Either<Failure, List<Note>>> getNotes() async{
   try{

     final result = await baseNotesLocalDataSource.getNotes();
     return Right(result);

   }on LocalDatabaseException catch(e){
     return Left(LocalDatabaseFailure(e.message));
   }

  }

  @override
  Future<Either<Failure, void>> addNote(Note note) async{

    try{

      final result=await baseNotesLocalDataSource.addNote(note);
      return Right(result);

    }on LocalDatabaseException catch(e){
      return Left(LocalDatabaseFailure(e.message));
    }

  }

  @override
  Future<Either<Failure, void>> updateNote(Note note)async {
    try{

      final result=await baseNotesLocalDataSource.updateNote(note);
      return Right(result);

    }on LocalDatabaseException catch(e){
      return Left(LocalDatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(int noteId)async {
    try{

      final result=await baseNotesLocalDataSource.deleteNote(noteId);
      return Right(result);

    }on LocalDatabaseException catch(e){
      return Left(LocalDatabaseFailure(e.message));
    }
  }



}