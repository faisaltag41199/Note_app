import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/local_data_source_helper/hive_database_helper.dart';
import 'package:noteapp/core/utils/constance/app_style.dart';
import 'package:noteapp/core/utils/theme/app_theme_data/themedata_dark.dart';
import 'package:noteapp/core/utils/theme/theme_mode.dart';
import 'package:noteapp/presentation/blocs/dark_mode_bloc/dark_mode_block.dart';
import 'package:noteapp/presentation/blocs/dark_mode_bloc/dark_mode_state.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_bloc.dart';
import 'package:noteapp/presentation/blocs/note_bloc/note_event.dart';
import 'package:noteapp/presentation/ui/HomeScreen.dart';

import 'core/Services/services_locator.dart';
import 'core/utils/theme/app_theme_data/themedata_light.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  await HiveDatabaseHelper.initHiveBoxes().then((_)async{

   DarkModeThemeStatus.isDarkMode=await HiveDatabaseHelper().getDarkModeStatus();

  });

  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider(create:(context)=>serviceLocator<DarkModeBloc>()),
      BlocProvider(
          create: (context)=>serviceLocator<NoteBloc>()..add(GetNotesEvent()),
      )
    ],child: BlocBuilder<DarkModeBloc,DarkModeState>(builder: (context,state){

        if(state is DarkModeSuccessState){
          print("DarkModeSuccessState");

        }
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          title: 'Flutter Note App',
          theme: ThemeDataLight.themeDataLight(),
          darkTheme: ThemeDataDark.themeDataDark(),
          themeMode: DarkModeThemeStatus.isDarkMode?ThemeMode.dark:ThemeMode.light,
          home: SafeArea(
            child: NotesHomeScreen(),
          )
       );

    },));
  }
}

