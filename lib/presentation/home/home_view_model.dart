import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/app/database/dbhelper.dart';
import 'package:cater_ease/app/deviceinfo.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:cater_ease/network/apis.dart';
import 'package:cater_ease/network/networkinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/customer_function_model.dart';
import '../../model/customer_model.dart';
import '../../network/failure.dart';
import '../string_manager.dart';

class HomeViewModelController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  BuildContext context;
  HomeViewModelController(this.context);

  Future<List<FutureFunctionView>> getCustomerFutureFunction() async {
    List<FutureFunctionView> futureFunctions = [];
    try {
      if (!(await NetworkInfo.isConnected())) {
        EasyLoading.dismiss();
        EasyLoading.showError(AppStrings.errorNotConnected);
        return [];
      }
      final SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      String? catererId = await _sharedPreferences.getString(CATERER_ID);
      final result =
          await AppServiceClient.getPendingFutureFunctions(catererId!);
      if (result is Failure) {
        print("result " + result.toString());
        return List.empty();
      }

      for (CustomerFunction customerFunction
          in List<CustomerFunction>.from(result)) {
        Customer customer =
            await DBHelper.getCustomerFromId(customerFunction.customerId);
        FutureFunctionView futureFunctionView =
            FutureFunctionView(customer, customerFunction);
        futureFunctions.add(futureFunctionView);
      }
      return futureFunctions;
    } catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      return [];
    }
  }

  Future<dynamic?> signUpUser(String userName, String email, String password,
      String mobileNo, String catererName, String place) async {
    EasyLoading.show();
    String result = "Error while Registration!";

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String catererId = await generateCatererId();
      String imei = await DeviceInfo.getUniqueDeviceId();
      await _firestore.collection("users").doc(credential.user!.uid).set({
        "userId": credential.user!.uid,
        "userName": userName.trim(),
        "email": email.trim(),
        "mobile": mobileNo.trim(),
        "imei": imei.toString(),
        "catererName": catererName.trim(),
        "catererId": catererId,
        "password": password.trim(),
        "isActive": true,
        "msg": "",
      }).whenComplete(() {
        _firestore.collection("caterers").doc(catererId).set({
          "catererId": catererId,
          "catererName": catererName.trim(),
          "mobile": mobileNo.trim(),
          "email": email.trim(),
          "place": place.trim(),
          "logo": "",
          "isActive": false,
          "msg": "This caterer is not activated, please contact support",
        });
      });
      result = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'week-password') {
        result = AppStrings.weekPassword;
      } else if (e.code == 'email-already-in-use') {
        result = AppStrings.emailAlreadyExist;
      } else {
        result = e.code.toString();
      }
      EasyLoading.dismiss();
    } catch (e) {
      result = e.toString();
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
    return result;
  }
}

class FutureFunctionView {
  CustomerFunction customerFunction;
  Customer customer;
  FutureFunctionView(this.customer, this.customerFunction);
}
