import 'package:cater_ease/app/constants.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerFunction {
  int? functionId;
  String functionName;
  String catererId;
  int customerId;
  String? address;
  DateTime? startDate;
  DateTime? endDate;

  CustomerFunction(
      {required this.customerId,
      this.functionId,
      required this.functionName,
      required this.catererId,
      this.address,
      this.startDate,
      this.endDate});

  factory CustomerFunction.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CustomerFunction(
        customerId: data?[DBConstant.CUSTOMER_ID],
        functionId: data?[DBConstant.FUNCTION_ID],
        functionName: data?[DBConstant.FUNCTION_NAME],
        catererId: data?[DBConstant.CATERER_ID],
        address: data?[DBConstant.ADDRESS],
        startDate: data?[DBConstant.FUNCTION_START_DATE],
        endDate: data?[DBConstant.FUNCTION_END_DATE]);
  }

  Map<String, dynamic> toMap() {
    return {
      DBConstant.CUSTOMER_ID: customerId,
      DBConstant.FUNCTION_NAME: functionName,
      DBConstant.CATERER_ID: catererId,
      DBConstant.ADDRESS: address ?? "",
      DBConstant.FUNCTION_START_DATE: getStringFromDate(startDate!, "YYYY-MM-DD") ?? "",
      DBConstant.FUNCTION_END_DATE: getStringFromDate(endDate!, "YYYY-MM-DD") ?? ""
    };
  }

  String toString() {
    return "name - " + functionName + " address - " + address!;
  }
}
