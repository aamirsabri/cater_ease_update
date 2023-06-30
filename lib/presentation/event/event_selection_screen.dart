import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/model/response.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../network/failure.dart';
import '../color_manager.dart';
import '../font_manager.dart';
import '../route_manager.dart';
import '../string_manager.dart';
import '../style_manager.dart';
import 'event_selection_view_model.dart';

class EventSelectionScreen extends StatefulWidget {
  const EventSelectionScreen({super.key});

  @override
  State<EventSelectionScreen> createState() => _EventSelectionScreenState();
}

class _EventSelectionScreenState extends State<EventSelectionScreen> {
  late EventSelectionViewModel _eventSelectionViewModel;
  late String catererId;
  List<EventMasterViewModel> _events = [];
  Future<EventSelectionViewModel> getEventSelectionViewModel() async {
    return EventSelectionViewModel(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventSelectionViewModel().then((value) {
      _eventSelectionViewModel = value;
      catererId = Provider.of<CatererProvider>(context).caterer!.catererId;
      _eventSelectionViewModel.getEventMasters(catererId).then((value) {
        if (value is Failure) {
          EasyLoading.showError("Error Occured while");
        } else {
          _events = List.from(value);
          _events.forEach((event) {
            print("Event: " + event.toMap().toString());
          });
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        elevation: 0,
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
<<<<<<< HEAD
              width: MediaQuery.of(context).size.width * .70,
=======
              width: MediaQuery.of(context).size.width * .79,
>>>>>>> bfd48b135bf2963e39453c8e2ecb7a31db992a55
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorManager.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: ColorManager.lightGrey,
                  ),
                  Expanded(
<<<<<<< HEAD
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "",
                          hintStyle:
                              TextStyle(fontSize: FontSize.appBarLabelSize),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
=======
                    child: SizedBox(
                      height: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            hintText: AppStrings.eventSearchLabel,
                            hintStyle: TextStyle(
                                fontSize: FontSize.appBarLabelSize,
                                color: ColorManager.lightGrey),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none
                            // isDense: true
                            ),
                      ),
>>>>>>> bfd48b135bf2963e39453c8e2ecb7a31db992a55
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorManager.white,
<<<<<<< HEAD
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
=======
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),

>>>>>>> bfd48b135bf2963e39453c8e2ecb7a31db992a55
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(AppSize.borderRadius),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Icon(
                      Icons.food_bank,
                      size: AppSize.listTileIconSize,
                      color: ColorManager.secondaryFont,
                    ),
                    horizontalTitleGap: 8,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    title: Text(
                      "Mandap Muhurt",
                      style: getRegularStyle(
                          fontColor: ColorManager.secondaryFont,
                          fontSize: FontSize.mediumLargeSize),
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: ColorManager.secondaryFont,
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 4,
                  tileColor: ColorManager.primary,
                  leading: Icon(Icons.food_bank),
                  title: Text("Mandap Muhurt"),
                  trailing: Icon(
                    Icons.add,
                    color: ColorManager.secondaryFont,
                    size: FontSize.mediumLargeSize,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
