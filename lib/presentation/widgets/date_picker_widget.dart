import 'package:cater_ease/app/functions.dart';
import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../string_manager.dart';
import '../style_manager.dart';

class MyDatePicker extends StatefulWidget {
  String label;
  Function(DateTime selectedDate) callBack;
  MyDatePicker(this.label,this.callBack);
  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return 
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              widget.label??"તારીખ પસંદ કરો",
              style: getRegularStyle(
                  fontColor: ColorManager.primary,
                  fontSize: FontSize.labelSize),
            ),
          ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:16.0),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    SizedBox(width: 8,),
                    Text(selectedDate!=null?getStringFromDate(selectedDate!, "dd-MM-yyyy")!:"Select Date",style: getRegularStyle(
                  fontColor: ColorManager.secondaryFont,
                  fontSize: FontSize.labelSize),
            ),
                  ],
                ),
              ),
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  widget.callBack(pickedDate);
                  setState(() {
                    selectedDate = pickedDate;
                  });
                  
                }
              },
            ),
          ],
        );
      
    
  }
}