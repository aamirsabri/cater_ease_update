import 'package:cater_ease/presentation/auth/register_view_model.dart';
import 'package:cater_ease/presentation/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



import 'login_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModelController? _registerViewModelController;


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
  void didChangeDependencies() async {    // TODO: implement didChangeDependencies
   
    EasyLoading.dismiss();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _registerViewModelController = RegisterViewModelController(context);
    return Scaffold(
    );
  }
}
