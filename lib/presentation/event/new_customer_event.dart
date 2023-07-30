import 'package:cater_ease/app/functions.dart';
import 'package:cater_ease/network/failure.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/common/show_snack.dart';
import 'package:cater_ease/presentation/event/new_customer_event_view_model.dart';
import 'package:cater_ease/presentation/font_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:cater_ease/presentation/widget/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../string_manager.dart';

class NewCustomerEvent extends StatefulWidget {
  String title;
  String eventMasterId;
  NewCustomerEvent({required this.title, required this.eventMasterId});

  @override
  State<NewCustomerEvent> createState() => _NewCustomerEventState();
}

class _NewCustomerEventState extends State<NewCustomerEvent> {
  late NewCustomerEventViewModel _newCustomerEventViewModel;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _placeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool _isVipEvent = false;
  DateTime _functionStartDate = DateTime.now();
  TimeOfDay _eventTime = TimeOfDay(hour: 10, minute: 00);
  DateTime _eventDate = DateTime.now();

  Future<NewCustomerEventViewModel> getNewCustomerEventViewModel() async {
    return NewCustomerEventViewModel(context);
  }

  @override
  void initState() {
    super.initState();
    getNewCustomerEventViewModel().then((value) {
      _newCustomerEventViewModel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: ColorManager.primary),
        title: Text(
          widget.title,
          style: getSemiBoldStyle(
              fontColor: ColorManager.primary,
              fontSize: FontSize.appBarLabelSize),
        ),
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _placeController,
                    validator: (place) {
                      if (place == null || place == "") {
                        return "Place cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: AppStrings.placeLabel,
                        labelStyle: getMediumStyle(
                            fontColor: ColorManager.primary,
                            fontSize: FontSize.buttonFontSize),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.primary))),
                  ),
                  SizedBox(
                    height: AppSize.s30,
                  ),
                  InkWell(
                    child: TextFormField(
                      enabled: false,
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelStyle: getMediumStyle(
                            fontColor: ColorManager.primary,
                            fontSize: FontSize.buttonFontSize),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: ColorManager.primary,
                        ),
                        labelText: getStringFromDate(_eventDate, "dd-MMM-yyyy"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.borderRadius)),
                      ),
                    ),
                    onTap: () async {
                      showDatePicker(
                              context: context,
                              initialDate: _functionStartDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 2))
                          .then((pickedDate) {
                        setState(() {
                          _eventDate = pickedDate ?? _eventDate;
                        });
                      });
                    },
                  ),
                  SizedBox(
                    height: AppSize.s30,
                  ),
                  InkWell(
                    child: TextFormField(
                      enabled: false,
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelStyle: getMediumStyle(
                            fontColor: ColorManager.primary,
                            fontSize: FontSize.buttonFontSize),
                        prefixIcon: Icon(
                          Icons.lock_clock_rounded,
                          color: ColorManager.primary,
                        ),
                        labelText: getStringFromTIme(_eventTime),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.borderRadius)),
                      ),
                    ),
                    onTap: () async {
                      showTimePicker(
                        context: context,
                        initialTime: _eventTime,
                      ).then((pickedTime) {
                        setState(() {
                          _eventTime = pickedTime ?? _eventTime;
                        });
                      });
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print("valid");
                            await _newCustomerEventViewModel
                                .createNewCustomerEvent(
                                    widget.eventMasterId,
                                    _placeController.text,
                                    _eventDate,
                                    _eventTime,
                                    _isVipEvent)
                                .then((result) {
                              if (result is Failure) {
                                EasyLoading.dismiss();
                                EasyLoading.showError(result.messege);
                              } else if (result is String) {
                                showSnack(context, result.toString());
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            showSnack(context, "Please Enter valid inputs");
                          }
                        },
                        child: Text(
                          AppStrings.okButtonLabel,
                          style: getSemiBoldStyle(
                            fontColor: ColorManager.secondaryFont,
                            fontSize: FontSize.buttonFontSize,
                          ),
                        )),
                  ),
                ]),
          )),
    );
  }
}
