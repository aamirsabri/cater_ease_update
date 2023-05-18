import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/model/caterer_model.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/common/show_snack.dart';
import 'package:cater_ease/presentation/string_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';
import '../font_manager.dart';
import 'new_function_view_model.dart';

class NewFunctionScreen extends StatefulWidget {
  const NewFunctionScreen({super.key});

  @override
  State<NewFunctionScreen> createState() => _NewFunctionScreenState();
}

class _NewFunctionScreenState extends State<NewFunctionScreen> {
  CustomerProvider? customerProvider;
  Customer? _customer;
  late String catererId;
  NewFunctionNewViewModel? _newFunctionNewViewModel;
  List<String> mobiles = [];
  List<String> functionTypes = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customerAddress = TextEditingController();
  TextEditingController _customerMobile = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _functionName = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  TextEditingController _familyNameController = TextEditingController();
  TextEditingController _customerEmail = TextEditingController();

  List<String> getSuggesions(String pattern) {
    List<String> result = [];
    mobiles.forEach((element) {
      if (element.contains(pattern)) {
        result.add(element);
      }
    });
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    getNewFunctionViewModel().then((value) {
      _newFunctionNewViewModel = value;
    }).then((value) {
      _newFunctionNewViewModel!.getAllConsumers().then((value) {
        if (value is Map<String, Customer>) {
          mobiles = List.from(value.keys);
          print(mobiles);
        }
      });
    });
    super.initState();
  }

  Future<NewFunctionNewViewModel> getNewFunctionViewModel() async {
    return NewFunctionNewViewModel(context);
  }

  @override
  void didChangeDependencies() async {
    customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    // TODO: implement didChangeDependencies

    _newFunctionNewViewModel = NewFunctionNewViewModel(context);
    if (functionTypes == null || functionTypes.isEmpty) {
      catererId = Provider.of<CatererProvider>(context).caterer!.catererId;
      final result =
          await _newFunctionNewViewModel!.getFunctionSuggesions(catererId);
      print("caterer id " + catererId + " result " + result.toString());
      EasyLoading.dismiss();
      if (result is List) {
        // functionTypes = result;
        setState(() {
          functionTypes = List.from(result as List<String>);
        });
      } else {
        showSnack(context, result.toString());
      }
      super.didChangeDependencies();
    }

    // if(customer != null){
    //   _nameController.text = customer!.customerName;
    //   _mobileController.text = customer!.mobile;
    //   _placeController.text = customer!.address!;
    //   _customerEmail.text = customer!.email!;
    // }
  }

  List<String> getFunctionSuggesions(String pattern) {
    List<String> result = [];
    functionTypes.forEach((element) {
      if (element.contains(pattern)) {
        result.add(element);
      }
    });
    return result;
  }

  Future showNewConsumerDialog() async {
    final _customerFormKey = GlobalKey<FormState>();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Form(
                key: _customerFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            AppStrings.newConsumerLabel,
                            style: getRegularStyle(
                                fontColor: ColorManager.primary,
                                fontSize: FontSize.appBarLabelSize),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buidTextFormField(
                          controller: _nameController,
                          label: AppStrings.customerNameLabel + "*"),
                      buidTextFormField(
                          controller: _customerMobile,
                          label: AppStrings.mobileNoLabel),
                      buidTextFormField(
                          controller: _customerEmail,
                          label: AppStrings.emailLabel),
                      buidTextFormField(
                          controller: _customerAddress,
                          label: AppStrings.addressLabel),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (_customerFormKey.currentState?.validate() ?? false) {
                      final res = await _newFunctionNewViewModel!
                          .saveNewCustomer(
                              _nameController.text,
                              _customerEmail.text,
                              _customerMobile.text,
                              _customerAddress.text);
                      EasyLoading.dismiss();
                      if (res == "success") {
                        Navigator.pop(context);
                        showSnack(context, AppStrings.newCustomerAdded);
                      } else {
                        showSnack(context, res);
                      }
                    } else {
                      showSnack(context, "Enter valid values");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary),
                  //return false when click on "NO"
                  child: Text(
                    AppStrings.okButtonLabel,
                    style: getSemiBoldStyle(
                        fontColor: ColorManager.secondaryFont,
                        fontSize: FontSize.buttonFontSize),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    _customer = customerProvider!.currentCustomer;
    if (_customer != null) {
      _nameController.text = _customer!.customerName;
      if (_placeController.text == "") {
        _placeController.text = _customer!.address!;
      }
      if (_mobileController.text == "")
        _mobileController.text = _customer!.mobile;
      if (_familyNameController.text == "") {
        _familyNameController.text = _nameController.text.split(' ').length > 2
            ? _nameController.text.split(' ')[1] + " " + AppStrings.familyLabel
            : _nameController.text.split(' ')[0] + " " + AppStrings.familyLabel;
      }
    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        labelText: AppStrings.searchCustomerHint,
                        icon: Icon(Icons.search),
                        hintText: AppStrings.mobileNoLabel),
                  ),
                  itemBuilder: (BuildContext context, String suggestion) {
                    return ListTile(title: Text(suggestion));
                  },
                  onSuggestionSelected: (String suggestion) {
                    _searchController.text = suggestion;
                  },
                  suggestionsCallback: (String pattern) {
                    return getSuggesions(pattern);
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        controller: _nameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorManager.disabledColor,
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSize.borderRadius),
                              borderSide:
                                  BorderSide(color: ColorManager.disabledColor),
                            ),
                            hintText: AppStrings.customerNameLabel),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showNewConsumerDialog();
                        },
                        icon: Icon(
                          Icons.add,
                          color: ColorManager.primary,
                        )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Text(
                    AppStrings.functionNameLabel,
                    style: getRegularStyle(
                        fontColor: ColorManager.primary,
                        fontSize: FontSize.labelSize),
                  ),
                ),
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _functionName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.borderRadius),
                      ),
                      hintText: AppStrings.functionNameHint,
                      hintStyle: getRegularStyle(
                          fontColor: ColorManager.lightGrey,
                          fontSize: FontSize.labelSize),
                    ),
                  ),
                  itemBuilder: (BuildContext context, String suggestion) {
                    return ListTile(title: Text(suggestion));
                  },
                  onSuggestionSelected: (String suggestion) {
                    _functionName.text = suggestion;
                  },
                  suggestionsCallback: (String pattern) {
                    return getFunctionSuggesions(pattern);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                buidTextFormField(
                    controller: _mobileController,
                    label: AppStrings.mobileNoLabel),
                buidTextFormField(
                    controller: _placeController, label: AppStrings.placeLabel),
                buidTextFormField(
                    controller: _familyNameController,
                    label: AppStrings.familyNameLabel),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final res = await _newFunctionNewViewModel!
                          .saveNewFunction(
                              _customer!.customerId!,
                              _functionName.text +
                                  " " +
                                  AppStrings.celebrationLabel,
                              _placeController.text,
                              DateTime.now(),
                              DateTime.now());
                      EasyLoading.dismiss();
                      if (res.toString() == "success") {
                        showSnack(
                            context, AppStrings.newFunctionCreationSuccess);
                      } else {
                        print(res.toString());
                        showSnack(context, res.toString());
                      }
                    } else {
                      showSnack(context, "Enter valid values");
                    }
                  },
                  child: Text(
                    "ઓ કે",
                    style: getSemiBoldStyle(
                        fontColor: ColorManager.secondaryFont,
                        fontSize: FontSize.appBarLabelSize),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      minimumSize: Size.fromHeight(AppSize.buttonHeight)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buidTextFormField(
      {initialValue, controller, label, hint, icon, enable, formKey}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              label ?? "",
              style: getRegularStyle(
                  fontColor: ColorManager.primary,
                  fontSize: FontSize.labelSize),
            ),
          ),
          TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return "value must not be null";
              }
              return null;
            }),
            enabled: enable,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.borderRadius),
                borderSide: BorderSide(color: ColorManager.disabledColor),
              ),
              icon: icon,
            ),
          ),
        ],
      ),
    );
  }
}
