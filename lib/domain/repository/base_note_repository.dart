import 'package:dartz/dartz.dart';
import 'package:noteapp/core/error/failure.dart';

import '../entities/note_dir/note.dart';

abstract class BaseNoteRepository{

  Future<Either<Failure,List<Note>>> getNotes();
  Future<Either<Failure,void>> addNote(Note note);
  Future<Either<Failure,void>> updateNote(Note note);
  Future<Either<Failure,void>> deleteNote(int noteId);

}



