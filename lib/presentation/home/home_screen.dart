import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/font_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:cater_ease/presentation/widget/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(16)),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          children: [
            Container(
              child: ListTile(
                minLeadingWidth: 1,
                horizontalTitleGap: 12,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/svg/home.svg",
                      width: 40,
                      height: 40,
                      color: ColorManager.white,
                    ),
                  ],
                ),
                title: Text(
                  'Drawer Header',
                  style: getSemiBoldStyle(
                      fontColor: ColorManager.white,
                      fontSize: FontSize.bigSize),
                ),
                subtitle: Text(
                  'Drawer Header',
                  style: getSemiBoldStyle(
                      fontColor: ColorManager.white,
                      fontSize: FontSize.smallSize),
                ),
              ),
            ),
            Divider(
              color: ColorManager.white,
            ),
            DrawerListItem(
              title: "HOME",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "MY PROFILE",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "CUSTOMER",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "EVENT",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "DISH",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "MENU ITEM",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "PAST FUNCTIONS",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "MY PROFILE",
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: "MANAGE USER",
              icon: "assets/icons/svg/home.svg",
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(child: Text("Home")),
    );
  }
}
