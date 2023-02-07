
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/error/exception.dart';
import 'package:noteapp/core/utils/theme/theme_mode.dart';
import 'package:noteapp/presentation/blocs/dark_mode_bloc/dark_mode_event.dart';

import '../../../core/local_data_source_helper/hive_database_helper.dart';
import 'dark_mode_state.dart';

class DarkModeBloc extends Bloc<DarkModeEvent,DarkModeState>{

  DarkModeBloc():super(DarkModeInitialState()){

    on<EnableDarkModeEvent>(_EnableDarkModeEventHandler);

  }

  static DarkModeBloc darkModeBloc(BuildContext context)
    => BlocProvider.of<DarkModeBloc>(context);

  _EnableDarkModeEventHandler(EnableDarkModeEvent event,Emitter<DarkModeState> emit)async{

    emit(DarkModeLoadingState());

    try{

      await HiveDatabaseHelper().enableDarkMode(event.darkMode);
      DarkModeThemeStatus.isDarkMode=event.darkMode;

      emit(DarkModeSuccessState());

    }on LocalDatabaseException catch(e){
      emit(DarkModeErrorState(e.message));

    }






  }
}