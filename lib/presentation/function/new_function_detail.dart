import 'package:cater_ease/domain/customer_provider.dart';
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
  Customer? currentCustomer;
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentCustomer = Provider.of<CustomerProvider>(context).currentCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primaryFont),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.newFunction,
              style: getRegularStyle(
                  fontColor: ColorManager.primary,
                  fontSize: FontSize.appBarLabelSize),
            )),
      ),
      
    );
  }
}