import 'package:cater_ease/app/language/language.dart';
import 'package:cater_ease/app/language/languageEn.dart';
import 'package:cater_ease/presentation/auth/register_view_model.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:cater_ease/presentation/common/show_snack.dart';
import 'package:cater_ease/presentation/font_manager.dart';
import 'package:cater_ease/presentation/route_manager.dart';
import 'package:cater_ease/presentation/string_manager.dart';
import 'package:cater_ease/presentation/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../value_manager.dart';
import 'login_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterViewModelController _registerViewModelController;
  TextEditingController _passwordConroller = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _catererController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _placeController = TextEditingController();

  int? _selectedCompanyCode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    _registerViewModelController = RegisterViewModelController(context);

    super.didChangeDependencies();
  }

  signUpUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      String res = await _registerViewModelController.signUpUser(
          _userNameController.text,
          _emailController.text,
          _passwordConroller.text,
          _phoneController.text,
          _catererController.text,
          _placeController.text);
      EasyLoading.dismiss();
      if (res == "success") {
        showSnack(
            context,
            Languages.of(context)?.successfullySignedUp ??
                AppStrings.successfullySignedUp);
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      } else {
        showSnack(context, res);
      }
    } else {
      return showSnack(context, "Please Enter Valid Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .25,
              color: ColorManager.primary,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context)?.appName ?? AppStrings.appName,
                      style: getBoldStyle(
                          fontColor: ColorManager.secondaryFont,
                          fontSize: FontSize.extraBigSize),
                    ),
                    Text(
                      Languages.of(context)?.appTag ?? AppStrings.appTag,
                      style: getBoldStyle(
                        fontColor: ColorManager.secondaryFont,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSize.s20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                controller: _userNameController,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return "Name must not be empty";
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.usernameHint ??
                        AppStrings.usernameHint),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return "Mobile No must not be empty";
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.mobileHint ??
                        AppStrings.mobileHint),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return "Email must not be empty";
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.emailHint ??
                        AppStrings.emailHint),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                controller: _catererController,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return "Caterer Name must not be empty";
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.catererName ??
                        AppStrings.catererName),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                obscureText: true,
                controller: _passwordConroller,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password must not be empty";
                  } else if (value != _confirmPasswordController.text) {
                    return "Both Password must be same";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.passwordHint ??
                        AppStrings.passwordHint),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password must not be empty";
                  } else if (value != _confirmPasswordController.text) {
                    return "Both Password must be same";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.confirmPasswordHint ??
                        AppStrings.confirmPasswordHint),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
              child: TextFormField(
                controller: _placeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Place name must not be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: Languages.of(context)?.placeNameHint ??
                        AppStrings.placeNameHint),
              ),
            ),
            const SizedBox(
              height: 63,
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: AppPadding.p16),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
            //     ),
            //     onPressed: () async{
            //       signUpUser();
            //     },
            //     child: Text(Languages.of(context)?.registerLabel ?? AppStrings.registerLabel,style: getSemiBoldStyle(fontColor: ColorManager.secondaryFont,fontSize: FontSize.mediumLargeSize),),
            //     ),
            // ),
          ]),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
              shape: ContinuousRectangleBorder()),
          onPressed: () async {
            signUpUser();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Languages.of(context)?.registerLabel ??
                    AppStrings.registerLabel,
                style: getSemiBoldStyle(
                    fontColor: ColorManager.secondaryFont,
                    fontSize: FontSize.mediumLargeSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
