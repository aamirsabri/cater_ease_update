import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  int? customerId;
  String customerName;
  String? email;
  String? address;
  String mobile;

  Customer(
      {this.customerId,
      required this.customerName,
      this.email,
      required this.mobile,
      this.address});

  factory Customer.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Customer(
        customerId: data?[DBConstant.CUSTOMER_ID],
        customerName: data?[DBConstant.CUSTOMER_NAME],
        address: data?[DBConstant.ADDRESS] ?? "",
        email: data?[DBConstant.EMAIL] ?? "",
        mobile: data?[DBConstant.CUSTOMER_MOBILE]);
  }

  factory Customer.fromMap(Map<String, dynamic>? data) {
    return Customer(
        customerId: data?[DBConstant.CUSTOMER_ID],
        customerName: data?[DBConstant.CUSTOMER_NAME],
        address: data?[DBConstant.ADDRESS] ?? "",
        email: data?[DBConstant.EMAIL] ?? "",
        mobile: data?[DBConstant.CUSTOMER_MOBILE]);
  }

  Map<String, dynamic> toMap() {
    return {
      DBConstant.CUSTOMER_NAME: customerName,
      DBConstant.EMAIL: email ?? "",
      DBConstant.CUSTOMER_MOBILE: mobile,
      DBConstant.ADDRESS: address ?? ""
    };
  }

  String toString() {
    return " name - " + customerName + " address - " + address! ?? "";
  }
}
