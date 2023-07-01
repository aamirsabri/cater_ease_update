import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/app/constants.dart';
import 'package:cater_ease/app/database/dbhelper.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/domain/user_provider.dart';
import 'package:cater_ease/model/caterer_model.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/font_manager.dart';
import 'package:cater_ease/presentation/function/new_function_detail.dart';
import 'package:cater_ease/presentation/home/home_view_model.dart';
import 'package:cater_ease/presentation/route_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:cater_ease/presentation/widget/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:cater_ease/model/user_model.dart' as user;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../model/customer_function_model.dart';
import '../../model/customer_model.dart';
import '../string_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModelController? _homeViewModelController;
  user.User? _user;
  Caterer? _caterer;
  List<FutureFunctionView> _futureCustomerFunctions = [];

  @override
  void initState() {
    super.initState();
    getHomeViewModel().then((value) {
      _homeViewModelController = value;
    }).then((value) {
      EasyLoading.show();
      fetchFutureFunctions();
      // _homeViewModelController!.getCustomerFutureFunction().then((result) {
      //   EasyLoading.dismiss();
      //   if (!result.isEmpty) {
      //     _futureCustomerFunctions = List<FutureFunctionView>.from(result);
      //     setState(() {});
      //   } else {
      //     print("result is empty");
      //   }
      // });
    });
  }

  Future<List<FutureFunctionView>?> fetchFutureFunctions() async {
    return _homeViewModelController!.getCustomerFutureFunction().then((result) {
      EasyLoading.dismiss();
      if (!result.isEmpty) {
        _futureCustomerFunctions = List<FutureFunctionView>.from(result);
        setState(() {});
        return _futureCustomerFunctions;
        
      } else {
        print("result is empty");
        return [];
      }
    });
  }

  Future<HomeViewModelController> getHomeViewModel() async {
    return HomeViewModelController(context);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _user = await Provider.of<UserDetailProvider>(context, listen: true).user;
    print("user " + _user!.userName);
    _caterer =
        await Provider.of<CatererProvider>(context, listen: true).caterer;
    setState(() {});
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
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 120,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: Divider.createBorderSide(
                            context,
                            color: ColorManager.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                      // child: Row(
                      //   children: [
                      //     Icon(
                      //       Icons.account_circle,
                      //       size: 55,
                      //       color: ColorManager.white,
                      //     ),
                      //     Text("Heder"),
                      //   ],
                      // ),
                      child: ListTile(
                        horizontalTitleGap: 12,
                        leading: Column(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 55,
                              color: ColorManager.white,
                            ),
                          ],
                        ),
                        title: Text(
                          _user?.catererName ?? "",
                          style: getRegularStyle(
                              fontColor: ColorManager.white,
                              fontSize: FontSize.bigSize),
                        ),
                        subtitle: Text(
                          _user?.email ?? "",
                          style: getRegularStyle(
                              fontColor: ColorManager.white,
                              fontSize: FontSize.mediumSize),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Divider(
                      color: ColorManager.white,
                    ),
                  ),
                  DrawerListItem(
                    title: AppStrings.home,
                    icon: "assets/icons/svg/home.svg",
                    screenName: DRAWER_SCREEN.HOME,
                  ),
                  DrawerListItem(
                      title: AppStrings.myprofile,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.MY_PROFILE),
                  DrawerListItem(
                      title: AppStrings.customer,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.CUSTOMER),
                  DrawerListItem(
                      title: AppStrings.event,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.EVENT),
                  DrawerListItem(
                      title: AppStrings.dish,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.DISH),
                  DrawerListItem(
                      title: AppStrings.menuItem,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.MENU_ITEM),
                  DrawerListItem(
                      title: AppStrings.pastFunction,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.PAST_FUNCTIONS),
                  DrawerListItem(
                      title: AppStrings.manageUser,
                      icon: "assets/icons/svg/home.svg",
                      screenName: DRAWER_SCREEN.MANAGE_USER),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: ColorManager.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.logout,
                        color: ColorManager.white,
                      ),
                      label: Text(
                        "Log out",
                        style: getRegularStyle(
                            fontColor: ColorManager.white,
                            fontSize: FontSize.drowerListItemFontSize),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CustomerProvider>(context, listen: false)
                    .resetCustomerProvider();
                Navigator.pushNamed(context, Routes.newFunction);
              },
              icon: Icon(
                Icons.add,
                size: 35,
              )),
        ],
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.dashboardLabel,
              style: getRegularStyle(
                  fontColor: ColorManager.secondaryFont,
                  fontSize: FontSize.appBarLabelSize),
            )),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppStrings.futureFunctionLabel,
                      style: getRegularStyle(
                          fontColor: ColorManager.secondaryFont,
                          fontSize: FontSize.appBarLabelSize),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.21,
                    width: double.infinity,
                    child: PageView.builder(
                        itemCount: _futureCustomerFunctions.length,
                        controller: PageController(
                          initialPage: 1,
                          viewportFraction: 0.90,
                        ),
                        itemBuilder: (context, index) {
                          CustomerFunction customerFunction =
                              _futureCustomerFunctions[index].customerFunction;
                          Customer customer =
                              _futureCustomerFunctions[index].customer;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return NewFunctionDetailScreen();
                                    },
                                    settings: RouteSettings(arguments: {
                                      DBConstant.CUSTOMER_ID:
                                          customerFunction.customerId,
                                      DBConstant.FUNCTION_ID:
                                          customerFunction.functionId
                                    }),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius:
                                    BorderRadius.circular(AppSize.borderRadius),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        customerFunction.familyName,
                                        style: getRegularStyle(
                                            fontColor: ColorManager.primary,
                                            fontSize: FontSize.mediumLargeSize),
                                      ),
                                      if (customerFunction.startDate != null)
                                        Text(
                                          getStringFromDate(
                                              customerFunction.startDate!,
                                              "dd-MM-yyyy")!,
                                          style: getRegularStyle(
                                              fontColor: ColorManager.primary,
                                              fontSize: FontSize.mediumSize),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    AppStrings.totalEventsLabel,
                                    style: getRegularStyle(
                                        fontColor: ColorManager.primary,
                                        fontSize: FontSize.mediumSize),
                                  ),
                                  Text(
                                    AppStrings.totalDaysLabel,
                                    style: getRegularStyle(
                                        fontColor: ColorManager.primary,
                                        fontSize: FontSize.mediumSize),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        customer.customerName,
                                        style: getRegularStyle(
                                            fontColor: ColorManager.primary,
                                            fontSize: FontSize.mediumSize),
                                      )),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        customer.mobile,
                                        style: getRegularStyle(
                                            fontColor: ColorManager.primary,
                                            fontSize: FontSize.mediumSize),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }),
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
