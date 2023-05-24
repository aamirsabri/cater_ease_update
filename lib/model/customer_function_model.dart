import 'package:cater_ease/app/constants.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerFunction {
  int? functionId;
  String functionName;
  String catererId;
  int customerId;
  String? address;
  String familyName;
  DateTime? startDate;
  DateTime? endDate;

  CustomerFunction(
      {required this.customerId,
      this.functionId,
      required this.functionName,
      required this.catererId,
      this.address,
      required this.familyName,
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
        familyName: data?[DBConstant.FUNCTION_FAMILY_NAME],
        startDate: data?[DBConstant.FUNCTION_START_DATE],
        endDate: data?[DBConstant.FUNCTION_END_DATE]);
  }

  Map<String, dynamic> toMap() {
    return {
      DBConstant.CUSTOMER_ID: customerId,
      DBConstant.FUNCTION_NAME: functionName,
      DBConstant.CATERER_ID: catererId,
      DBConstant.ADDRESS: address ?? "",
      DBConstant.FUNCTION_FAMILY_NAME: familyName??"",
      DBConstant.FUNCTION_START_DATE: (startDate!=null?getStringFromDate(startDate!, "yyyy-MM-dd hh:mm:ss")!:""),
      DBConstant.FUNCTION_END_DATE: (endDate!=null?getStringFromDate(endDate!, "yyyy-MM-dd hh:mm:ss")!:"")
    };
  }

  factory CustomerFunction.fromMap(Map<String, dynamic>? data) {
    return CustomerFunction(
        customerId: data?[DBConstant.CUSTOMER_ID],
        functionName: data?[DBConstant.FUNCTION_NAME],
        address: data?[DBConstant.ADDRESS] ?? "",
        functionId: data?[DBConstant.FUNCTION_ID],
        catererId: data?[DBConstant.CATERER_ID],
        familyName: data?[DBConstant.FUNCTION_FAMILY_NAME]??"",
        startDate: (data?[DBConstant.FUNCTION_START_DATE]!="")?data![DBConstant.FUNCTION_START_DATE]:null,
        endDate: (data?[DBConstant.FUNCTION_END_DATE]!="")?data![DBConstant.FUNCTION_END_DATE]:null,
        
        );

  }

  String toString() {
    return "name - " + functionName + " address - " + address!;
  }
}
