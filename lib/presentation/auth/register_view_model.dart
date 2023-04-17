import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';

import '../../domain/user_provider.dart';
import '../../model/user_model.dart';
import '../../network/apis.dart';
import '../../network/failure.dart';

class RegisterViewModelController {
  BuildContext context;
  RegisterViewModelController(this.context);
  Future<dynamic?> login(
      int companyId, String empId, String password) async {
   
  }

  Future<dynamic> _fetchData() async {
    var result = await AppServiceClient.getAllCompanyMaster();
    return result;
  }
}
