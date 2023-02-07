
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/core/utils/constance/app_style.dart';
import '../app_colors/colors_lightmode.dart';

class ThemeDataLight{

  static ThemeData themeDataLight()=> ThemeData(


    primaryColor: ColorsLightMode.primaryColor,
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
      backgroundColor: ColorsLightMode.primaryColor,
      foregroundColor: ColorsLightMode.floatingButtonForegroundColor
    ),
   cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
     primaryColor:  ColorsLightMode.primaryColor,
   ),

   scaffoldBackgroundColor: ColorsLightMode.backgroundColor,
    cardTheme: CardTheme(color: ColorsLightMode.cardColor ,
    elevation:10,
    ),

    textTheme: TextTheme(
      titleMedium: const TextStyle(color:ColorsLightMode.textTitleColor,
          fontWeight: AppStyle.textTitleFontWeight,
          fontSize: AppStyle.textMediumTitleSize
      ) ,
      bodyMedium: const TextStyle(color:ColorsLightMode.textTitleColor,
          fontSize: AppStyle.textMediumBodySize
      ),
      titleSmall:TextStyle(color:ColorsLightMode.textTitleColor,
          fontWeight: AppStyle.textTitleFontWeight,
        fontSize: AppStyle.textSmallTitleSize
      ),
      bodySmall: TextStyle(color:ColorsLightMode.textTitleColor,
          fontSize: AppStyle.textSmallBodySize
      ),


    ),
   );
}