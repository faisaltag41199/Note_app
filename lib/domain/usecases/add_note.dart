import 'package:dartz/dartz.dart';
import 'package:noteapp/core/error/failure.dart';
import 'package:noteapp/core/usecases/note_base_usecase.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';

import '../repository/base_note_repository.dart';

class AddNoteUsecase implements NoteBaseUsecase<void,Note>{

  late final BaseNoteRepository baseNoteRepository;

  AddNoteUsecase(this.baseNoteRepository);

  @override
  Future<Either<Failure, void>> call(Note note) async {

      return await baseNoteRepository.addNote(note);
  }



}