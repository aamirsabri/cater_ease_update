import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String catererId;
  String? catererName;
  String email;
  String? imei;
  String? msg;
  String userId;
  String userName;
  String password;
  String? mobile;
  bool isActive;

  User({
    required this.catererId,
    this.catererName,
    required this.email,
    this.imei,
    this.msg,
    required this.userId,
    required this.userName,
    required this.password,
    required this.mobile,
    required this.isActive
    });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
    
  ) {
      final data = snapshot.data();
      return User(
        imei: data?[COL_IMEI],
        catererId: data?[COL_CATERER_ID],
        catererName: data?[COL_CATERER_NAME],
        email: data?[COL_EMAIL],       
        mobile: data?[COL_MOBILE],
        userId: data?[COL_USER_ID],
        userName: data?[COL_USER_NAME],
        password: data?[COL_PASSWORD],
        isActive: data?[COL_IS_ACTIVE],
        msg: data?[COL_MSG],
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      COL_CATERER_ID: catererId,
      COL_CATERER_NAME: catererName,
      COL_EMAIL: email,
      COL_MOBILE: mobile??'',
      COL_USER_ID:userId,
      COL_USER_NAME:userName,
      COL_MSG:msg??"",
      COL_IMEI:imei??"",
      COL_PASSWORD:password,
      COL_IS_ACTIVE:isActive??false,
    };
  }
}