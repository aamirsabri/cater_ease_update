import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/app/deviceinfo.dart';
import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/user_provider.dart';
import 'package:cater_ease/model/caterer_model.dart';
import 'package:cater_ease/model/requests.dart';
import 'package:cater_ease/network/apis.dart';
import 'package:cater_ease/network/error_handling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cater_ease/model/user_model.dart' as user;

import '../../app/constants.dart';
import '../../network/failure.dart';
import '../../network/networkinfo.dart';

class LoginViewModelController {
  BuildContext context;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String res = "Something went wrong while login!";
  LoginViewModelController(this.context);

  Future<dynamic?> autoLogin() async {
    try {
      final SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      AppPreference appPreference = AppPreference(_sharedPreferences);
      String email = await appPreference.getValue(EMAIL);
      String password = await appPreference.getValue(PASSWORD);
      if (email == '') {
        return "fail";
      } else {
        final result = await signInUser(email, password);
        if (result is User) {
          return "success";
        }
        return "fail";
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return "fail";
    }
  }

  Future<dynamic?> signInUser(String email, String password) async {
    String catererId;
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    AppPreference appPreference = AppPreference(_sharedPreferences);

    try {
      await NetworkInfo.isConnected().then((value) {
        if (!value) {
          return "No Internet Connection!";
        }
      });
      String imei = await DeviceInfo.getUniqueDeviceId();
      dynamic result = await AppServiceClient.login(LoginRequest(
        email: email.trim(),
        password: password.trim(),
        imei: imei,
      ));
      print("result in model " + result.toString());
      if ((result is! user.User)) {
        return result;
      }

      await Provider.of<UserDetailProvider>(context, listen: false)
          .updateUser(result as user.User);
      await _sharedPreferences.setString(EMAIL, email.toString());
      await _sharedPreferences.setString(PASSWORD, password.toString());
      catererId = (result as user.User).catererId;
      print("cat id " + catererId);
      await Provider.of<CatererProvider>(context, listen: false)
          .fetchCatererDetail(catererId);
      appPreference.setPref(CATERER_ID, catererId);

      return result;
    } catch (e) {
      print("erorr in signin model");
      res = e.toString();

      return Failure(ResponseCode.UNKNOWN, res.toString());
    }
  }

  // Future<dynamic?> signInUser2(String email, String password) async {
  //   String catererId;
  //   final SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   AppPreference appPreference = AppPreference(_sharedPreferences);

  //   try {
  //     await NetworkInfo.isConnected().then((value) {
  //       if (!value) {
  //         return "No Internet Connection!";
  //       }
  //     });

  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email.trim(), password: password.trim());
  //     DocumentReference _currentUserRef =
  //         _firestore.collection("users").doc(credential.user!.uid);
  //     String imei =
  //         await _currentUserRef.get().then((DocumentSnapshot doc) async {
  //       Provider.of<UserDetailProvider>(context, listen: false).updateUser(
  //           user.User.fromFirestore(
  //               doc as DocumentSnapshot<Map<String, dynamic>>));
  //       final data = doc.data() as Map<String, dynamic>;
  //       catererId = data[COL_CATERER_ID];
  //       await Provider.of<CatererProvider>(context, listen: false)
  //           .fetchCatererDetail(catererId);
  //       appPreference.setPref(CATERER_ID, catererId);
  //       return data["imei"];
  //     });
  //     String currentImei = await DeviceInfo.getUniqueDeviceId();
  //     if (imei == currentImei) {
  //       await appPreference.setPref(EMAIL, email);
  //       await appPreference.setPref(PASSWORD, password);

  //       res = "success";
  //     } else {
  //       res = "Your Device ID does not match";
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       res = 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       res = 'Wrong password!';
  //     } else {
  //       res = e.code;
  //     }
  //     return res;
  //   } catch (e) {
  //     res = e.toString();
  //     return res;
  //   }
  //   return res;
  // }

  // Future<dynamic> _fetchData() async {
  //   var result = await AppServiceClient.getAllCompanyMaster();
  //   return result;
  // }
}
