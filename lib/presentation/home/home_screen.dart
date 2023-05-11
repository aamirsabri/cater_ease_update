import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/user_provider.dart';
import 'package:cater_ease/model/caterer_model.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/font_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:cater_ease/presentation/widget/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:cater_ease/model/user_model.dart' as user;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../string_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  user.User? _user;
  Caterer? _caterer;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _user = await Provider.of<UserDetailProvider>(context,listen: false).user;
    print("user " + _user!.userName);
    _caterer = await Provider.of<CatererProvider>(context,listen: false).caterer;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(16)),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      minLeadingWidth: 1,
                      horizontalTitleGap: 12,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_circle,size: 55,color: ColorManager.white,),
                        ],
                      ),
                      title: Text(
                        _user?.catererName??"",
                        style: getSemiBoldStyle(
                            fontColor: ColorManager.white,
                            fontSize: FontSize.bigSize),
                      ),
                      subtitle: Text(
                        _user?.email??"",
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
              title: AppStrings.home,
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: AppStrings.myprofile,
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: AppStrings.customer,
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: AppStrings.event,
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: AppStrings.dish,
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: AppStrings.menuItem,
              icon: "assets/icons/svg/home.svg",
            ),
            DrawerListItem(
              title: AppStrings.pastFunction,
              icon: "assets/icons/svg/home.svg",
            ),
            
            DrawerListItem(
              title: AppStrings.manageUser,
              icon: "assets/icons/svg/home.svg",
            ),
    
          ],
          ),
            ),
            Column(
              
              children: [
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DrawerListItem(
                              title: AppStrings.manageUser,
                              icon: "assets/icons/svg/home.svg",
                            ),
                ),
              ),
            ],),
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
