import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/font_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:flutter/material.dart';

showSnack(context,String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(title,style: getSemiBoldStyle(fontColor: ColorManager.secondaryFont,fontSize: FontSize.mediumSize),)),
    backgroundColor: ColorManager.primary,
    ));
}