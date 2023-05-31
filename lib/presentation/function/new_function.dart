import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/model/caterer_model.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/common/show_snack.dart';
import 'package:cater_ease/presentation/route_manager.dart';
import 'package:cater_ease/presentation/string_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:cater_ease/presentation/value_manager.dart';
import 'package:cater_ease/presentation/widgets/date_picker_widget.dart';
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
  Map<String, Customer> _customers = {};
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
  late DateTime fromDate;
  DateTime? toDate;

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
        print(value.toString());
        if (value is Map<String, Customer>) {
          _customers = value;
          final List<MapEntry<String, Customer>> mapEntries =
              _customers.entries.toList();
          mobiles = mapEntries.map((customer) {
            return '${customer.key}-${customer.value.toString()}';
          }).toList();

          print(mobiles);
        }
      });
    });
    super.initState();
    _functionName.text = "લગ્ન";
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

  void populateSelectedCustomerDetail(String selectedCustomer) {
    String selectedMobile = selectedCustomer.split("-")[0];
    _customer = _customers[selectedMobile];
    print("customer id " + _customer!.customerId.toString());
    if (_customer != null) {
      customerProvider!.updateCustomer(_customer!);
    }

    print(_customer.toString());
    _nameController.text = _customer!.customerName;
    _placeController.text = _customer!.address ?? "";
    _mobileController.text = _customer!.mobile;
    _familyNameController.text = _customer!.customerName.split(' ').length > 2
        ? _customer!.customerName.split(' ')[1] + " " + AppStrings.familyLabel
        : _customer!.customerName.split(' ')[0] + " " + AppStrings.familyLabel;
    setState(() {});
  }

  Future showNewConsumerDialog() async {
    TextEditingController _newCustomernameController = TextEditingController();
    TextEditingController _newCustomerMobile = TextEditingController();
    TextEditingController _newCustomerAddress = TextEditingController();
    TextEditingController _newCustomerEmail = TextEditingController();
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
                          controller: _newCustomernameController,
                          label: AppStrings.customerNameLabel + "*"),
                      buidTextFormField(
                          controller: _newCustomerMobile,
                          label: AppStrings.mobileNoLabel),
                      buidTextFormField(
                          controller: _newCustomerEmail,
                          label: AppStrings.emailLabel),
                      buidTextFormField(
                          controller: _newCustomerAddress,
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
                              _newCustomernameController.text,
                              _newCustomerEmail.text,
                              _newCustomerMobile.text,
                              _newCustomerAddress.text);
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

  void updateFromDateCallBack(DateTime selectedDate) {
    fromDate = selectedDate ?? fromDate;
  }

  void updateToDateCallBack(DateTime selectedDate) {
    toDate = selectedDate ?? toDate;
  }

  @override
  Widget build(BuildContext context) {
    _customer = customerProvider!.currentCustomer;
    if (_customer != null) {
      _nameController.text = _customer!.customerName;
      if (_placeController.text == "" ||
          _placeController.text != _customer!.address!) {
        _placeController.text = _customer!.address!;
      }
      if (_mobileController.text == "" ||
          _mobileController.text != _customer!.mobile)
        _mobileController.text = _customer!.mobile;

      _familyNameController.text = _nameController.text.split(' ').length > 2
          ? _nameController.text.split(' ')[1] + " " + AppStrings.familyLabel
          : _nameController.text.split(' ')[0] + " " + AppStrings.familyLabel;
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
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.screenPadding,
              horizontal: AppPadding.screenPadding),
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
                    populateSelectedCustomerDetail(_searchController.text);
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
                const SizedBox(
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
                const SizedBox(
                  height: 10,
                ),
                MyDatePicker(AppStrings.fromDateLabel, updateFromDateCallBack),
                const SizedBox(
                  height: 10,
                ),
                MyDatePicker(AppStrings.toDateLabel, updateToDateCallBack),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("_customer id " + _customer.toString());
                    print("family name " + _familyNameController.text);
                    if (_formKey.currentState?.validate() ?? false) {
                      final res =
                          await _newFunctionNewViewModel!.saveNewFunction(
                        _customer!.customerId!,
                        _functionName.text +
                            "ની " +
                            AppStrings.celebrationLabel,
                        _placeController.text,
                        fromDate,
                        toDate,
                        _familyNameController.text,
                        _functionName.text
                      );
                      EasyLoading.dismiss();
                      if (res.toString() == "success") {
                        showSnack(
                            context, AppStrings.newFunctionCreationSuccess);
                        Navigator.pushReplacementNamed(
                            context, Routes.newFunctionDetail);
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
