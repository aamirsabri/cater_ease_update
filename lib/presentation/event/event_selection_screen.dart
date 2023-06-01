import 'package:cater_ease/presentation/value_manager.dart';
import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../route_manager.dart';
import '../string_manager.dart';
import '../style_manager.dart';

class EventSelectionScreen extends StatefulWidget {
  const EventSelectionScreen({super.key});

  @override
  State<EventSelectionScreen> createState() => _EventSelectionScreenState();
}

class _EventSelectionScreenState extends State<EventSelectionScreen> {
  EventSelectionViewModel? _eventSelectionViewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.newFunction);
              },
              icon: Icon(
                Icons.add,
                size: 35,
              )),
        ],
        iconTheme: IconThemeData(color: ColorManager.secondaryFont),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.appBar_eventSection,
              style: getRegularStyle(
                  fontColor: ColorManager.secondaryFont,
                  fontSize: FontSize.appBarLabelSize),
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * .70,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorManager.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search,color: ColorManager.lightGrey,),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "dadfkkd",
                          hintStyle:
                              TextStyle(fontSize: FontSize.appBarLabelSize),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height:24),
          Container(
            
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16git)),

            ),
            child: Column(
              children: [
                Container(                
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(AppSize.borderRadius),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),                                
                    leading: Icon(Icons.food_bank,size: AppSize.listTileIconSize,color: ColorManager.secondaryFont,),
                    horizontalTitleGap: 8,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                    title: Text("Mandap Muhurt",style: getRegularStyle(fontColor: ColorManager.secondaryFont,fontSize: FontSize.mediumLargeSize),),
                    trailing: Icon(Icons.add,color: ColorManager.secondaryFont,),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 4,
                  tileColor: ColorManager.primary,              
                  leading: Icon(Icons.food_bank),
                  title: Text("Mandap Muhurt"),
                  trailing: Icon(Icons.add,color: ColorManager.secondaryFont,size: FontSize.mediumLargeSize,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
