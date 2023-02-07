import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/utils/theme/theme_mode.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';
import 'package:noteapp/presentation/blocs/dark_mode_bloc/dark_mode_block.dart';
import 'package:noteapp/presentation/blocs/dark_mode_bloc/dark_mode_event.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_bloc.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_event.dart';
import 'package:noteapp/presentation/ui/AddNoteScreen.dart';
import 'package:noteapp/presentation/ui/UpdateNoteScreen.dart';

import '../blocs/note_bloc/note_state.dart';

class NotesHomeScreen extends StatefulWidget{
  NotesHomeScreen({Key? key}) : super(key: key);

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> with SingleTickerProviderStateMixin{


  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  @override
  void initState() {
    super.initState();

    animationController=AnimationController(duration: Duration(seconds: 1),vsync: this);
    sizeAnimation=Tween(begin: 1.0,end:18.0).animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedBuilder(
                          animation: animationController,
                          builder: (context,_){

                           return Opacity(
                             opacity: animationController.value,
                             child: Text
                             (
                             "Note App",
                             style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                 fontSize:sizeAnimation.value ),
                             ),
                           );

                      }),
                      CupertinoSwitch(
                          value: DarkModeThemeStatus.isDarkMode,
                          onChanged: (bool value) {
                            print('darkMode value change : $value');
                            DarkModeBloc.darkModeBloc(context)
                                .add(EnableDarkModeEvent(value));
                          })
                    ],
                  )),
            ),
            Expanded(
                flex: 8,
                child: BlocConsumer<NoteBloc, NoteState>(
                  listener: (context, state) {
                    if (state is GetNotesErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'error ${state.errorMessage}',
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is GetNotesErrorState) {
                      return Center(
                        child: Text(
                          'No Notes Yet',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    } else if (state is GetNotesSuccessState) {
                      print('in GetNotesSuccessState');

                      if(state.notes.isEmpty){
                        return Center(child:Text('no notes yet',style:Theme.of(context).textTheme.bodySmall,));
                      }

                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          state.notes[index].title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(state.notes[index].content!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                        title: Text(
                                          "Note Options",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        actions: [
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateNoteScreen(
                                                              note: state.notes[
                                                                  index])));
                                            },
                                            child: Text(
                                              "Update Note",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                          CupertinoActionSheetAction(
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _showIosAlertDialog(context,
                                                  state.notes[index].id);
                                            },
                                            child: Text("Delete Note"),
                                          )
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                             child: Text("Cancel",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                      );
                                    });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: state.notes.length);
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: Theme.of(context)
                              .cupertinoOverrideTheme!
                              .primaryColor,
                        ),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
      ),
    );
  }

  _showIosAlertDialog(context, noteId) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Text("Delete Note"),
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ],
            ),
            content: BlocConsumer<NoteBloc, NoteState>(
              listener: (context, state) {
                if (state is DeleteNoteSuccessState) {
                  NoteBloc.noteBloc(context).add(GetNotesEvent());
                  Navigator.of(context).pop();
                }

                if (state is DeleteNoteErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'error ${state.errorMessage}',
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));

                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is DeleteNoteLoadingState) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: Theme.of(context)
                          .cupertinoOverrideTheme!
                          .primaryColor,
                    ),
                  );
                }
                return new Text("Do you want to delete this note ");
              },
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Yes"),
                onPressed: () {
                  _deleteNote(context, noteId);
                },
              ),
              CupertinoDialogAction(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _deleteNote(context, noteId) {
    NoteBloc.noteBloc(context).add(DeleteNoteEvent(noteId));
  }
}
