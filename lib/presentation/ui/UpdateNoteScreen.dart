import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/local_data_source_helper/hive_database_helper.dart';
import '../../core/utils/constance/app_style.dart';
import '../../domain/entities/note_dir/note.dart';
import '../blocs/note_bloc/note_bloc.dart';
import '../blocs/note_bloc/note_event.dart';
import '../blocs/note_bloc/note_state.dart';

class UpdateNoteScreen extends StatelessWidget {
  UpdateNoteScreen({required this.note});

  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title!;
    contentController.text = note.content!;

    return BlocConsumer<NoteBloc, NoteState>(listener: (context, state) {
      if (state is UpdateNoteSuccessState) {
        NoteBloc.noteBloc(context).add(GetNotesEvent());
        Navigator.of(context).pop();
      }

      if (state is UpdateNoteErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'error ${state.errorMessage}',
            style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      }
    }, builder: (context, state) {
      return Scaffold(
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              leading: CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).cupertinoOverrideTheme!.primaryColor,
                  size: AppStyle.iosNavBarItemSize,
                ),
              ),
              middle: Text(
                'Add Note',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: AppStyle.iosNavBarItemSize),
              ),
              trailing: CupertinoButton(
                onPressed: () {
                  print(titleController.text);
                  print(contentController.text);

                  upDateNote(context, note.id);
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Theme.of(context)
                          .cupertinoOverrideTheme!
                          .primaryColor,
                      fontSize: AppStyle.iosNavBarItemSize),
                ),
              )),
          child: SafeArea(
            child: Column(
              children: [
                CupertinoTextField.borderless(
                    controller: titleController,
                    maxLines: 2,
                    placeholder: 'title...',
                    style: Theme.of(context).textTheme.titleMedium),
                Expanded(
                  child: CupertinoTextField.borderless(
                    controller: contentController,
                    placeholder: 'content...',
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    style: Theme.of(context).textTheme.bodyMedium,
                    expands: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void upDateNote(context, noteId) {
    String title = titleController.text;
    String content = contentController.text;

    Note note = Note(id: noteId, title: title, content: content);
    NoteBloc.noteBloc(context).add(UpdateNoteEvent(note));
  }
}
