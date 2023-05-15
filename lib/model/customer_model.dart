import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Customer{
  String customerId;
  String customerName;
  String? email;
  String? address; 
  String mobile;

  Customer({
    required this.customerId,
    required this.customerName,
    this.email,
    required this.mobile,
    this.address
    });

  factory Customer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
    
  ) {
      final data = snapshot.data();
      return Customer(
        customerId: data?[DBConstant.CUSTOMER_ID],
        customerName: data?[DBConstant.CUSTOMER_NAME],
        address: data?[DBConstant.ADDRESS],
        email: data?[DBConstant.EMAIL],       
        mobile: data?[DBConstant.WHATSAPP_NUMBER]        
      );
  }



  Map<String, dynamic> toMap() {
    return {
      DBConstant.CUSTOMER_ID: customerId,
      DBConstant.CUSTOMER_NAME: customerName,
      DBConstant.EMAIL: email??"",
      DBConstant.WHATSAPP_NUMBER: mobile,
      DBConstant.ADDRESS:address??"" 
    };
  }

  String toString(){
    return "customer_id - " + customerId + " name - " + customerName + " address - " + address!; 
  }
}