import 'package:cater_ease/app/language/language.dart';
import 'package:cater_ease/app/language/languageEn.dart';
import 'package:cater_ease/presentation/auth/register.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModelController _loginViewModelController;
  TextEditingController _passwordConroller = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loginViewModelController = LoginViewModelController(context);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    _loginViewModelController.autoLogin().then((res) {
      if (res == "success") {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    _loginViewModelController = LoginViewModelController(context);

    super.didChangeDependencies();
  }

  signInUser() async {
    EasyLoading.show();
    if (_formKey.currentState?.validate() ?? false) {
      String res = await _loginViewModelController.signInUser(
          _emailController.text, _passwordConroller.text);
      EasyLoading.dismiss();
      if (res == "success") {
        showSnack(
            context,
            Languages.of(context)?.successfullySignedIn ??
                AppStrings.successfullySignedIn);
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          SizedBox(
            height: 80,
          ),
          Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordConroller,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: Languages.of(context)?.passwordHint ??
                          AppStrings.passwordHint),
                ),
              ),
              SizedBox(height: AppSize.s20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                  ),
                  onPressed: () async {
                    await signInUser();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Languages.of(context)?.loginLabel ??
                            AppStrings.loginLabel,
                        style: getSemiBoldStyle(
                            fontColor: ColorManager.secondaryFont,
                            fontSize: FontSize.mediumLargeSize),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppPadding.p8),
                    child: Text(
                      AppStrings.dontHaveAccount,
                      style: getSemiBoldStyle(
                          fontColor: ColorManager.primaryFontOpacity70),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppPadding.p8),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                        },
                        child: Text(
                            Languages.of(context)?.registerLabel ??
                                AppStrings.registerLabel,
                            style: getBoldStyle(
                                fontColor: ColorManager.primary,
                                fontSize: FontSize.mediumLargeSize))),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
