

import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/note_base_usecase.dart';
import '../entities/note_dir/note.dart';
import '../repository/base_note_repository.dart';

class DeleteNoteUsecase implements NoteBaseUsecase<void,int>{

  late final BaseNoteRepository baseNoteRepository;

  DeleteNoteUsecase(this.baseNoteRepository);

  @override
  Future<Either<Failure, void>> call(int noteId) async {

    return await baseNoteRepository.deleteNote(noteId);
  }



}