import 'package:equatable/equatable.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';

class NoteState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialState extends NoteState{}


class GetNotesLoadingState extends NoteState{}
class GetNotesSuccessState extends NoteState{
  List<Note> notes=[];
  GetNotesSuccessState(this.notes);

  @override
  List<Object?> get props => [notes];
}
class GetNotesErrorState extends NoteState{
  String? errorMessage;
  GetNotesErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}


class AddNoteLoadingState extends NoteState{}
class AddNoteSuccessState extends NoteState{}
class AddNoteErrorState extends NoteState{
   String? errorMessage;

   AddNoteErrorState(this.errorMessage);

   @override
  List<Object?> get props => [errorMessage];
}


class UpdateNoteLoadingState extends NoteState{}
class UpdateNoteSuccessState extends NoteState{}
class UpdateNoteErrorState extends NoteState{
  String? errorMessage;
  UpdateNoteErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class DeleteNoteLoadingState extends NoteState{}
class DeleteNoteSuccessState extends NoteState{}
class DeleteNoteErrorState extends NoteState{
  String? errorMessage;
  DeleteNoteErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}




