import 'package:flutter/material.dart';

import '../app/constants.dart';

class SignUpRequest {
  String userName;
  String email;
  String password;
  String mobileNo;
  String catererName;
  String place;
  String imei;
  bool isActive;

  SignUpRequest(
      {required this.userName,
      required this.email,
      required this.password,
      required this.mobileNo,
      required this.catererName,
      required this.place,
      required this.imei,
      required this.isActive});

  Map<String, dynamic> toMap() {
    return {
      JSON_USER_NAME: userName,
      JSON_EMAIL: email,
      JSON_PASSWORD: password,
      JSON_MOBILE_NO: mobileNo,
      JSON_CATERER_NAME: catererName,
      JSON_PLACE: place,
      JSON_IMEI: imei,
      JSON_IS_ACTIVE: isActive
    };
  }
}

class LoginRequest {
  String email;
  String password;
  String imei;
  LoginRequest(
      {required this.email, required this.password, required this.imei});

  Map<String, dynamic> toMap() {
    return {JSON_EMAIL: email, JSON_PASSWORD: password, JSON_IMEI: imei};
  }
}
