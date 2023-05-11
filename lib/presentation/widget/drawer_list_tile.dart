import 'package:cater_ease/app/constants.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../style_manager.dart';
import '../value_manager.dart';

class DrawerListItem extends StatelessWidget {
  String title;
  String icon;
  DRAWER_SCREEN screenName;
  //Function callBack;
  DrawerListItem(
      {required this.title, required this.icon, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ListTile(
        horizontalTitleGap: 12,
        minLeadingWidth: 10,
        leading: SvgPicture.asset(
          icon,
          width: AppSize.drawerListItemIconSize,
          height: AppSize.drawerListItemIconSize,
          color: ColorManager.white,
        ),
        title: Text(
          title,
          style: getRegularStyle(
              fontColor: ColorManager.white,
              fontSize: FontSize.drowerListItemFontSize),
        ),
        onTap: () {
          Navigator.pop(context);
          if (screenName != null)
            Navigator.pushNamed(
                context, getRouteFromNavigationItem(screenName));
        },
      ),
    );
  }
}
