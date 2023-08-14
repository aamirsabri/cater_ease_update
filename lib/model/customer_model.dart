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
        customerId: data?[COL_CUSTOMER_ID],
        customerName: data?[COL_CUSTOMER_NAME],
        address: data?[COL_CUSTOMER_ADDRESS] ?? "",
        email: data?[COL_CUSTOMER_EMAIL] ?? "",
        mobile: data?[COL_CUSTOMER_MOBILE]);
  }

  Map<String, dynamic> toMap() {
    return {
      COL_CUSTOMER_NAME: customerName,
      COL_CUSTOMER_EMAIL: email ?? "",
      COL_CUSTOMER_MOBILE: mobile,
      COL_CUSTOMER_ADDRESS: address ?? ""
    };
  }

  String toString() =>
      "ID: ${customerId} Name: ${customerName} Address: ${address!} ?? '' Email: ${email} ";
}
