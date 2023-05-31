import 'package:cater_ease/app/constants.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/model/customer_function_model.dart';
import 'package:cater_ease/presentation/event/event_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';
import '../color_manager.dart';
import '../font_manager.dart';
import '../route_manager.dart';
import '../string_manager.dart';
import '../style_manager.dart';
import 'new_function_detail_view_model.dart';

class NewFunctionDetailScreen extends StatefulWidget {
  const NewFunctionDetailScreen({super.key});

  @override
  State<NewFunctionDetailScreen> createState() => _NewFunctionDetailScreenState();
}

class _NewFunctionDetailScreenState extends State<NewFunctionDetailScreen> {
  bool _isLoading = false;
  late CustomerProvider customerProvider;
  Customer? currentCustomer;
  CustomerFunction? customerFunction;
  late int customerId;
  late int functionId;
  late NewFunctionDetailViewModel _functionDetailViewModel;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    EasyLoading.show();
    getNewFunctionViewModel().then((value) {
      _functionDetailViewModel = value;
      _functionDetailViewModel.loadData().then((_){
      _isLoading = false;
      EasyLoading.dismiss();
      setState(() {
        
      });
      }).then((value) {
       
      });
    });
  }

  // Future<void> loadData()async{
  //   final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //   customerId = data[DBConstant.CUSTOMER_ID];
  //   functionId = data[DBConstant.FUNCTION_ID];
  //   Provider.of<CustomerProvider>(context).loadFunction(customerId,functionId).then((function) {
  //     customerFunction = function;
  //   });
  // }

  Future<NewFunctionDetailViewModel> getNewFunctionViewModel() async {
    return NewFunctionDetailViewModel(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    customerProvider = Provider.of<CustomerProvider>(context);
  // loadData().whenComplete(() {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
    currentCustomer = customerProvider.currentCustomer;
    customerFunction = customerProvider.currentFunction;
  }

  @override
  Widget build(BuildContext context) {
    currentCustomer = customerProvider.currentCustomer;
    customerFunction = customerProvider.currentFunction;
    return _isLoading?Center(child: CircularProgressIndicator(),):
    Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) {
                  return EventSelectionScreen();
                }));
              },
              icon: Icon(
                Icons.add,
                size: 35,
              )),
        ],
        backgroundColor: ColorManager.primary,
        iconTheme: IconThemeData(color: ColorManager.secondaryFont),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              customerFunction!.familyName,
              style: getRegularStyle(
                  fontColor: ColorManager.secondaryFont,
                  fontSize: FontSize.appBarLabelSize),
            )),
      ),
      body:SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background_food.jpg"),fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorManager.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        customerFunction!.functionName,
                        style: getSemiBoldStyle(fontColor: ColorManager.primary,fontSize: FontSize.functionNameSize),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        currentCustomer!.customerName,
                        style: getSemiBoldStyle(fontColor: ColorManager.secondaryFont,fontSize: FontSize.regularSize),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10, // Replace with the actual number of list items
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.info),
                title: Text('Item $index'),
                subtitle: Text('Subtitle $index'),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Handle the button tap to navigate to the detail screen
                    // You can use Navigator.push to navigate to the desired screen
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
      
    );
  }
}