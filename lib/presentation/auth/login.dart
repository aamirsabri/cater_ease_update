import 'package:cater_ease/app/language/language.dart';
import 'package:cater_ease/app/language/locale_constants.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app/functions.dart';
import '../../model/user_model.dart';
import '../../network/apis.dart';
import '../../network/failure.dart';
import '../font_manager.dart';
import '../route_manager.dart';
import '../string_manager.dart';
import '../style_manager.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModelController? _loginViewModelController;

  int? _selectedCompanyCode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    EasyLoading.show();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    changeLanguage(context, "en");

    EasyLoading.dismiss();
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _loginViewModelController = LoginViewModelController(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)?.appName ?? ""),
      ),
      body: Center(child: Text(Languages.of(context)?.appName ?? "fdjhf")),
    );
  }
}
