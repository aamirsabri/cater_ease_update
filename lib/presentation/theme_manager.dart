import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: "Montserrat",
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey,
    primaryColorDark: ColorManager.darkPrimary,

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
      centerTitle: true,
      titleTextStyle: getRegularStyle(fontColor: ColorManager.white,fontSize: FontSize.s16),

    ),

    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
      disabledColor:ColorManager.grey
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(fontColor: ColorManager.white,),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    textTheme: TextTheme(
      headline1: getSemiBoldStyle(fontColor: ColorManager.darkgrey,fontSize: FontSize.s16),
      subtitle1: getMediumStyle(fontColor: ColorManager.lightGrey,fontSize: FontSize.s14),
      subtitle2: getMediumStyle(fontColor: ColorManager.primary,fontSize: FontSize.s12),
      caption: getRegularStyle(fontColor: ColorManager.grey),
      bodyText1: getRegularStyle(fontColor: ColorManager.grey)
    ),

        inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p22),
      hintStyle: getRegularStyle(fontColor: ColorManager.grey),
      labelStyle: getMediumStyle(fontColor: ColorManager.darkgrey,fontSize: 14),
      errorStyle: getRegularStyle(fontColor: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey,width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error,width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary,width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary,width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      )


    ),
    
  );
}