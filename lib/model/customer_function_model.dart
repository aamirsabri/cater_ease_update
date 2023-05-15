import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CustomerFunction{
  String functionId;
  String functionName;
  String catererId;
  String customerId;
  String? address; 
  DateTime? startDate;
  DateTime? endDate;


  CustomerFunction({
    required this.customerId,
    required this.functionId,
    required this.functionName,
    required this.catererId,
    this.address,
    this.startDate,
    this.endDate
    });

  factory CustomerFunction.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
    
  ) {
      final data = snapshot.data();
      return CustomerFunction(
        customerId: data?[DBConstant.CUSTOMER_ID],
        functionId: data?[DBConstant.FUNCTION_ID],
        functionName: data?[DBConstant.FUNCTION_NAME],
        catererId: data?[DBConstant.CATERER_ID],
        address: data?[DBConstant.ADDRESS],
        startDate: data?[DBConstant.FUNCTION_START_DATE],       
        endDate: data?[DBConstant.FUNCTION_END_DATE]        
      );
  }



  Map<String, dynamic> toMap() {
    return {
      DBConstant.CUSTOMER_ID: customerId,
      DBConstant.FUNCTION_ID: functionId,
      DBConstant.FUNCTION_NAME: functionName,
      DBConstant.CATERER_ID: catererId,
      DBConstant.ADDRESS: address??"",
      DBConstant.FUNCTION_START_DATE: startDate??"",
      DBConstant.FUNCTION_END_DATE:endDate??"" 
    };
  }

  String toString(){
    return "FUNCTION ID - " + functionId + " name - " + functionName + " address - " + address!; 
  }
}