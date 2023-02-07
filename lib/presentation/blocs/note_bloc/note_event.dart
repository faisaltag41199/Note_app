import 'package:equatable/equatable.dart';

import '../../../domain/entities/note_dir/note.dart';

abstract class NoteEvent extends Equatable{
  const NoteEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetNotesEvent extends NoteEvent{}

class AddNoteEvent extends NoteEvent{
  final Note note;
  AddNoteEvent(this.note);

  @override
  // TODO: implement props
  List<Object?> get props => [note];

}

class UpdateNoteEvent extends NoteEvent{
  final Note note;
  UpdateNoteEvent(this.note);

  @override
  // TODO: implement props
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NoteEvent{
  final int noteId;
  DeleteNoteEvent(this.noteId);

  @override
  // TODO: implement props
  List<Object?> get props => [noteId];
}
