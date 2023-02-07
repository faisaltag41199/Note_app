import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constance/app_style.dart';
import '../app_colors/colors_darkmode.dart';

class ThemeDataDark{

  static ThemeData themeDataDark()=>ThemeData(
    primaryColor:ColorsDarkMode.primaryColor ,

    cupertinoOverrideTheme:NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
        barBackgroundColor:ColorsDarkMode.iosBarColor,
        primaryColor:  ColorsDarkMode.primaryColor,
    ) ,

    floatingActionButtonTheme:const FloatingActionButtonThemeData(
        backgroundColor: ColorsDarkMode.primaryColor
    ),

    scaffoldBackgroundColor: ColorsDarkMode.backgroundColor,
    cardTheme: const CardTheme(color: ColorsDarkMode.cardColor,
      elevation:10,

    ),
    brightness: Brightness.dark,

    textTheme: TextTheme(
      titleMedium:const TextStyle(color:ColorsDarkMode.textTitleColor,
          fontWeight: AppStyle.textTitleFontWeight,
          fontSize: AppStyle.textMediumTitleSize
      ) ,
      bodyMedium: const TextStyle(color:ColorsDarkMode.textTitleColor,
          fontSize: AppStyle.textMediumBodySize
      ),


      titleSmall:const TextStyle(color:ColorsDarkMode.textTitleColor,
          fontWeight: AppStyle.textTitleFontWeight,
          fontSize: AppStyle.textSmallTitleSize
      ),
      bodySmall: const TextStyle(color:ColorsDarkMode.textTitleColor,
          fontSize: AppStyle.textSmallBodySize
      ),


    ),
  );
}
