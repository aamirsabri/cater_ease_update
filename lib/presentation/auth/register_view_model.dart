import 'package:cater_ease/app/deviceinfo.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:cater_ease/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../network/apis.dart';
import '../../network/failure.dart';
import '../../network/networkinfo.dart';
import '../string_manager.dart';

class RegisterViewModelController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  BuildContext context;
  RegisterViewModelController(this.context);
  Future<dynamic?> signUpUser(String userName, String email, String password,
      String mobileNo, String catererName, String place) async {
    dynamic deviceInfo = await DeviceInfo.getUniqueDeviceId();
    if (deviceInfo is Failure) {
      return deviceInfo;
    }
    String imei = await DeviceInfo.getUniqueDeviceId();
    bool isActive = true;
    var result = await AppServiceClient.signUpUser(SignUpRequest(
      userName: userName,
      email: email.toLowerCase(),
      password: password,
      mobileNo: mobileNo,
      catererName: catererName,
      place: place,
      imei: imei,
      isActive: isActive,
    ));
    return result;
  }

  Future<dynamic?> signUpUser2(String userName, String email, String password,
      String mobileNo, String catererName, String place) async {
    EasyLoading.show();
    String result = "Error while Registration!";
    try {
      await NetworkInfo.isConnected().then((value) {
        if (!value) {
          return "No Internet Connection!";
        }
      });

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
