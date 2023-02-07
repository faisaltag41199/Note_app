import 'package:dartz/dartz.dart';
import 'package:noteapp/core/error/failure.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';

import '../../core/usecases/note_base_usecase.dart';
import '../repository/base_note_repository.dart';

class GetNotesUsecase implements NoteBaseUsecase<List<Note>,VoidParameters>{

  final BaseNoteRepository baseNoteRepository;

  GetNotesUsecase(this.baseNoteRepository);

  @override
  Future<Either<Failure,List<Note>>> call(VoidParameters parameters) async{
    return await baseNoteRepository.getNotes();

  }

}