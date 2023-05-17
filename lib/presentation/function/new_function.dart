import 'package:cater_ease/domain/caterer_provider.dart';
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

import '../font_manager.dart';
import 'new_function_view_model.dart';

class NewFunctionScreen extends StatefulWidget {
  const NewFunctionScreen({super.key});

  @override
  State<NewFunctionScreen> createState() => _NewFunctionScreenState();
}

class _NewFunctionScreenState extends State<NewFunctionScreen> {
  late String catererId;
  late NewFunctionNewViewModel _newFunctionNewViewModel;
  final mobiles = ["9824747764", "9876543210", "9824125412"];
  List<String> functionTypes =[];
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
    super.initState();

  }


@override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _newFunctionNewViewModel = NewFunctionNewViewModel(context);
    if(functionTypes==null || functionTypes.isEmpty){
      catererId = Provider.of<CatererProvider>(context).caterer!.catererId;
      final result = await _newFunctionNewViewModel.getFunctionSuggesions(catererId);
      print("caterer id " + catererId + " result "+ result.toString());
      EasyLoading.dismiss();
      if(result is List){
        // functionTypes = result;
        setState(() {
          functionTypes = List.from(result as List<String>);
        });
      }else{
        showSnack(context, result.toString());
      }
    }
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

  

  Future<Widget> showNewConsumerDialog() async {
    final _customerFormKey = GlobalKey<FormState>();
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
<<<<<<< HEAD
              content: Column(
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
                      label: AppStrings.customerNameLabel),
                  buidTextFormField(
                      controller: _customerMobile,
                      label: AppStrings.mobileNoLabel),
                  buidTextFormField(
                      controller: _customerAddress,
                      label: AppStrings.addressLabel),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary),
=======

              content: Form(
                key: _customerFormKey,
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
                        Text(AppStrings.newConsumerLabel,style: getRegularStyle(fontColor: ColorManager.primary,fontSize: FontSize.appBarLabelSize),),
                      ],
                    ),
                    SizedBox(height: 20,),
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
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if(_customerFormKey.currentState?.validate()??false){                      
                      final res = await _newFunctionNewViewModel.saveNewCustomer(_nameController.text,_customerEmail.text,_customerMobile.text,_customerAddress.text);
                      EasyLoading.dismiss();
                      if(res == "success"){
                        showSnack(context, AppStrings.newCustomerAdded);
                        Navigator.pop(context);
                      }else{
                        showSnack(context, res);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: ColorManager.primary),
>>>>>>> 4d956395f3aab0c1dc514170e99d395a8ef69476
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
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                      borderRadius: BorderRadius.circular(AppSize.borderRadius),
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
                onPressed: () {},
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
    );
  }

  Widget buidTextFormField({controller, label, hint, icon, enable,formKey}) {
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
              if(value == null || value.isEmpty){
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
