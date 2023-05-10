import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/app/deviceinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModelController {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
  String res = "Something went wrong while login!";
  LoginViewModelController();

  Future<dynamic?> autoLogin() async{
    try{
      final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
      AppPreference appPreference = AppPreference(_sharedPreferences);
      String email = await appPreference.getValue(EMAIL);
      String password = await appPreference.getValue(PASSWORD);
      if(email == ''){
        return "fail";
      }else{
        return await signInUser(email, password);
        
      }
    }catch(e){
      EasyLoading.showError(e.toString());
      return "fail";
    }

  }

  Future<dynamic?> signInUser(String email, String password) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    AppPreference appPreference = AppPreference(_sharedPreferences);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
      );
      DocumentReference _currentUserRef = _firestore.collection("users").doc(credential.user!.uid);
      String imei = await _currentUserRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data["imei"];
      });
      String currentImei = await DeviceInfo.getUniqueDeviceId();
      if(imei == currentImei){
        await appPreference.setPref(EMAIL, email);
        await appPreference.setPref(PASSWORD, password);        
        res = "success";
      }else{
        res = "Your Device ID does not match";
      }
    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
          res = 'Wrong password!';
      } else {
          res = e.code;
      }
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
    return res;
  }

  // Future<dynamic> _fetchData() async {
  //   var result = await AppServiceClient.getAllCompanyMaster();
  //   return result;
  // }
}
