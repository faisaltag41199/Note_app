import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/error/failure.dart';
import 'package:noteapp/core/usecases/note_base_usecase.dart';
import 'package:noteapp/domain/usecases/add_note.dart';
import 'package:noteapp/domain/usecases/delete_note.dart';
import 'package:noteapp/domain/usecases/get_notes.dart';
import 'package:noteapp/domain/usecases/update_note.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_event.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_state.dart';
import '../../../domain/entities/note_dir/note.dart';

class NoteBloc extends Bloc<NoteEvent,NoteState>{

  final AddNoteUsecase addNoteUsecase;
  final GetNotesUsecase getNotesUsecase;
  final UpdateNoteUsecase updateNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;

  NoteBloc(
      this.addNoteUsecase,
      this.getNotesUsecase,
      this.updateNoteUsecase,
      this.deleteNoteUsecase):super(InitialState()){

    on<AddNoteEvent>(_addNoteEventHandler);
    on<GetNotesEvent>(_getNotesEventHandler);
    on<UpdateNoteEvent>(_updateNoteEventHandler);
    on<DeleteNoteEvent>(_deleteNoteEventHandler);

  }
  int x =10;
  static NoteBloc noteBloc(BuildContext context) => BlocProvider.of<NoteBloc>(context);

  Future<void> _addNoteEventHandler(AddNoteEvent event,Emitter<NoteState> emit)async{

   emit(AddNoteLoadingState());

   final Either<Failure,void> result=await addNoteUsecase(event.note);
   result.fold((l) => emit(AddNoteErrorState(l.message)), (r) => emit(AddNoteSuccessState()));



  }

  Future<void> _getNotesEventHandler(GetNotesEvent event,Emitter<NoteState> emit)async{

    emit(GetNotesLoadingState());

    final Either<Failure,List<Note>> result=await getNotesUsecase(VoidParameters());
    result.fold((l) => emit(GetNotesErrorState(l.message)), (r) => emit(GetNotesSuccessState(r)));


  }

  Future<void> _updateNoteEventHandler(UpdateNoteEvent event,Emitter<NoteState> emit)async{

    emit(UpdateNoteLoadingState());

    final Either<Failure,void> result=await updateNoteUsecase(event.note);
    result.fold((l) => emit(UpdateNoteErrorState(l.message)), (r) => emit(UpdateNoteSuccessState()));

  }

  Future<void> _deleteNoteEventHandler(DeleteNoteEvent event,Emitter<NoteState> emit)async{

    emit(DeleteNoteLoadingState());

    final Either<Failure,void> result=await deleteNoteUsecase(event.noteId);
    result.fold((l) => emit(DeleteNoteErrorState(l.message)), (r) => emit(DeleteNoteSuccessState()));

  }

}