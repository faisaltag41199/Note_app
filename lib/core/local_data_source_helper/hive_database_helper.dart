

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/core/utils/constance/app_string.dart';
import 'package:noteapp/domain/entities/note_dir/note.dart';

import '../error/exception.dart';

class HiveDatabaseHelper{

  static Box? noteBoxInstance;
  static Box? _lastNoteIdBox;
  static Box? _themeModeBox;

  static Future<void> initHiveBoxes() async{

    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    noteBoxInstance = await Hive.openBox<Note>("noteBox");
    _lastNoteIdBox=await Hive.openBox("lastNoteIdBox");
    _themeModeBox=await Hive.openBox("themeModeBox");


  }

   int getNewNoteId(){

    if(_lastNoteIdBox!.containsKey(AppString.lastNoteIdKey)){

      int lastNoteId = _lastNoteIdBox!.get(AppString.lastNoteIdKey);
      int newNoteId =lastNoteId+1;
      _lastNoteIdBox!.put(AppString.lastNoteIdKey, newNoteId);
      return newNoteId;

    }else{

      _lastNoteIdBox!.put(AppString.lastNoteIdKey,1);
      return 1;

    }

  }
  Future<bool> getDarkModeStatus()async{

    try{

      if(_themeModeBox!.containsKey(AppString.themeModeKey)){

        bool themeModeKey = _themeModeBox!.get(AppString.themeModeKey);
        return themeModeKey;

      }else{

        _themeModeBox!.put(AppString.themeModeKey,false);
        return false;

      }

    }catch(e){
      throw LocalDatabaseException( message:e.toString());
    }

  }


   Future<void> enableDarkMode(bool darkModeStatus) async{

    try{

        return await _themeModeBox!.put(AppString.themeModeKey,darkModeStatus);

    }catch(e){

      throw LocalDatabaseException( message:e.toString());

    }

  }


}


