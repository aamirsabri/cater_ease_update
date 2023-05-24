import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/model/customer_function_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';
import '../color_manager.dart';
import '../font_manager.dart';
import '../string_manager.dart';
import '../style_manager.dart';

class NewFunctionDetailScreen extends StatefulWidget {
  const NewFunctionDetailScreen({super.key});

  @override
  State<NewFunctionDetailScreen> createState() => _NewFunctionDetailScreenState();
}

class _NewFunctionDetailScreenState extends State<NewFunctionDetailScreen> {
  late CustomerProvider customerProvider;
  Customer? currentCustomer;
  CustomerFunction? customerFunction;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    customerProvider = Provider.of<CustomerProvider>(context);
    currentCustomer = customerProvider.currentCustomer;
    customerFunction = customerProvider.customerFunction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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