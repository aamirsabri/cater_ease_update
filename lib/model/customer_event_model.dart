import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerEventModel {
  String? customerEventId;
  String catererId;
  int functionId;
  int customerId;
  String eventMasterId;
  String place;
  DateTime? eventDate;
  bool isVip;

  CustomerEventModel({
    this.customerEventId,
    required this.catererId,
    required this.functionId,
    required this.customerId,
    required this.eventMasterId,
    required this.place,
    this.eventDate,
    this.isVip = false,
  });

  factory CustomerEventModel.fromMap(Map<String, dynamic> data) {
    return CustomerEventModel(
        customerEventId: data[DBConstant.CUSTOMER_EVENT_ID],
        catererId: data[DBConstant.CATERER_ID],
        functionId: data[DBConstant.FUNCTION_ID],
        eventMasterId: data[DBConstant.EVENT_MASTER_ID],
        customerId: data[DBConstant.CUSTOMER_ID],
        eventDate: data[DBConstant.EVENT_DATE] ?? null,
        place: data[COL_PLACE],
        isVip: data[DBConstant.IS_VIP_MENU]);
  }

  Map<String, dynamic> toMap() {
    return {
      DBConstant.CUSTOMER_EVENT_ID: customerEventId,
      DBConstant.CATERER_ID: catererId,
      DBConstant.CUSTOMER_ID: customerId,
      DBConstant.FUNCTION_ID: functionId,
      DBConstant.EVENT_MASTER_ID: eventMasterId,
      DBConstant.EVENT_DATE: eventDate,
      DBConstant.EVENT_PLACE: place,
      DBConstant.IS_VIP_MENU: isVip ?? false,
    };
  }
}
