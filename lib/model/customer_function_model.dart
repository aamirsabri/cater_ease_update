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
  DateTime startDate;
  DateTime? endDate;
  String functionType;
  CustomerFunction(
      {required this.customerId,
      this.functionId,
      required this.functionName,
      required this.catererId,
      this.address,
      required this.familyName,
      required this.startDate,
      this.endDate,
      required this.functionType});

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
        endDate: data?[DBConstant.FUNCTION_END_DATE],
        functionType: data?[DBConstant.FUNCTION_TYPE]);
  }

  Map<String, dynamic> toMap() {
    print("start date " + getStringFromDate(startDate, "yyyy-MM-dd hh:mm:ss")!);
    return {
      DBConstant.CUSTOMER_ID: customerId,
      DBConstant.FUNCTION_NAME: functionName,
      DBConstant.CATERER_ID: catererId,
      DBConstant.ADDRESS: address ?? "",
      DBConstant.FUNCTION_FAMILY_NAME: familyName ?? "",
      DBConstant.FUNCTION_START_DATE: (startDate != null
          ? getStringFromDate(startDate, "yyyy-MM-dd hh:mm:ss")
          : ""),
      DBConstant.FUNCTION_END_DATE: (endDate != null
          ? getStringFromDate(endDate!, "yyyy-MM-dd hh:mm:ss")!
          : ""),
      DBConstant.FUNCTION_TYPE: functionType
    };
  }

  factory CustomerFunction.fromMap(Map<String, dynamic>? data) {
    return CustomerFunction(
      customerId: data?[DBConstant.CUSTOMER_ID],
      functionName: data?[DBConstant.FUNCTION_NAME],
      address: data?[DBConstant.ADDRESS] ?? "",
      functionId: data?[DBConstant.FUNCTION_ID],
      catererId: data?[DBConstant.CATERER_ID],
      familyName: data?[DBConstant.FUNCTION_FAMILY_NAME] ?? "",
      startDate: (data?[DBConstant.FUNCTION_START_DATE] != "")
          ? getDateFromString(
              data![DBConstant.FUNCTION_START_DATE], "yyyy-MM-dd hh:mm:ss")
          : null,
      endDate: (data?[DBConstant.FUNCTION_END_DATE] != "")
          ? getDateFromString(
              data![DBConstant.FUNCTION_END_DATE], "yyyy-MM-dd hh:mm:ss")
          : null,
      functionType: data?[DBConstant.FUNCTION_TYPE] ?? "",
    );
  }

  String toString() {
    return "name - " + functionName + " address - " + address!;
  }
}
