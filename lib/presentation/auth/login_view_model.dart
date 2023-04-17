import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModelController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BuildContext context;
  LoginViewModelController(this.context);
  Future<dynamic?> login(
      int companyId, String empId, String password) async {
        
  }

  // Future<dynamic> _fetchData() async {
  //   var result = await AppServiceClient.getAllCompanyMaster();
  //   return result;
  // }
}
