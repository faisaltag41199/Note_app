
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/note_base_usecase.dart';
import '../entities/note_dir/note.dart';
import '../repository/base_note_repository.dart';

class UpdateNoteUsecase implements NoteBaseUsecase<void,Note>{

  late final BaseNoteRepository baseNoteRepository;

  UpdateNoteUsecase(this.baseNoteRepository);

  @override
  Future<Either<Failure, void>> call(Note note) async {

    return await baseNoteRepository.updateNote(note);
  }



}