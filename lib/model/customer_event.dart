import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerEvent {
  int eventId;
  String catererId;
  int functionId;
  int eventMasterId;
  DateTime? eventDate;
  String? place;
  bool isVipMenu;

  CustomerEvent({
    required this.eventMasterId,
    required this.eventId,
    required this.catererId,
    required this.functionId,
    this.eventDate,
    this.place,
    this.isVipMenu = false,
  });

  factory CustomerEvent.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CustomerEvent(
      eventMasterId: data?[DBConstant.EVENT_MASTER_ID],
      eventId: data?[DBConstant.CUSTOMER_EVENT_ID],
      catererId: data?[DBConstant.CATERER_ID],
      functionId: data?[DBConstant.FUNCTION_ID],
      eventDate: data?[DBConstant.EVENT_DATE]??null,
      place: data?[DBConstant.EVENT_PLACE],
      isVipMenu: data?[DBConstant.IS_VIP_MENU],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      DBConstant.CATERER_ID: catererId,
      DBConstant.EVENT_MASTER_ID: eventMasterId,
      DBConstant.CUSTOMER_EVENT_ID: eventId,
      DBConstant.FUNCTION_ID:functionId
      DBConstant.EVENT_DATE: eventDate ?? '',
      DBConstant.EVENT_PLACE: place ?? '',
      DBConstant.IS_VIP_MENU: isVipMenu ?? false
    };
  }

  factory CustomerEvent.fromMap(Map<String, dynamic>? data) {
    return CustomerEvent(
        catererId: data?[DBConstant.CATERER_ID],
        eventMasterId: data?[DBConstant.EVENT_MASTER_ID],
        eventName: data?[DBConstant.EVENT_NAME],
        eventDescription: data?[DBConstant.EVENT_DESCRIPTION] ?? "",
        icon: data?[DBConstant.EVENT_ICON] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {
      DBConstant.EVENT_MASTER_ID: eventMasterId,
      DBConstant.CATERER_ID: catererId,
      DBConstant.EVENT_NAME: eventName,
      DBConstant.EVENT_DESCRIPTION: eventDescription ?? "",
      DBConstant.EVENT_ICON: icon
    };
  }

  String toString() =>
      "ID: ${eventMasterId} Event Name: ${eventName} Description: ${eventDescription!} ?? '' Cat Id: ${catererId} ";
}
