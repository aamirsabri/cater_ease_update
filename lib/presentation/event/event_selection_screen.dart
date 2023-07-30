import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/model/response.dart';
import 'package:cater_ease/presentation/event/new_customer_event.dart';
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
      catererId = Provider.of<CatererProvider>(context, listen: false)
          .caterer!
          .catererId;

      _eventSelectionViewModel.getEventMasters(catererId).then((value) {
        if (value is Failure) {
          EasyLoading.showError("Oops! Something went wrong");
        } else {
          _events = List.from(value);
          setState(() {});
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
              width: MediaQuery.of(context).size.width * .70,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(top: 32, bottom: 20, left: 24, right: 24),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  ...(_events.map((event) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius:
                              BorderRadius.circular(AppSize.borderRadius),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          leading: Image.network(event.imageUrl!,
                              height: AppSize.listTileIconSize,
                              fit: BoxFit.fill,
                              color: ColorManager.white),
                          horizontalTitleGap: 16,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          title: Text(
                            event.eventName,
                            style: getRegularStyle(
                                fontColor: ColorManager.secondaryFont,
                                fontSize: FontSize.tileTitleSize),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: ColorManager.secondaryFont,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewCustomerEvent(
                                            title: event.eventName,
                                            eventMasterId: event.eventMasterId,
                                          )));
                            },
                          ),
                        ));
                  }).toList()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
