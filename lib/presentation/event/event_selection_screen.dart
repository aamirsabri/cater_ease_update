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
          SizedBox(height: 24,),
          Center(
            child: Container(    
              padding: EdgeInsets.all(10),          
              width: MediaQuery.of(context).size.width*.79,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorManager.white
              ),
              child:  Row(     
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center, 
                       
                children: [
                  Icon(Icons.search,color: ColorManager.lightGrey,),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: TextFormField(                      
                        decoration: InputDecoration(
                          
                          contentPadding: EdgeInsets.all(6),
                          hintText: AppStrings.eventSearchLabel,
                          hintStyle: TextStyle(fontSize: FontSize.appBarLabelSize,color: ColorManager.lightGrey),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none
                          // isDense: true
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}