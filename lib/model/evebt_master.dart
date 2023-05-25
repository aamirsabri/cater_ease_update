import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventMaster{
  int eventMasterId;
  String catererId;
  String eventName;
  String? eventDescription;
  String? icon;


  EventMaster({
    required this.eventMasterId,
    required this.catererId,
    required this.eventName,
    this.eventDescription,
    this.icon,    
    });

  factory EventMaster.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
    
  ) {
      final data = snapshot.data();
      return EventMaster(
        eventMasterId: data?[DBConstant.EVENT_MASTER_ID],
        catererId: data?[DBConstant.CATERER_ID],
        eventName: data?[DBConstant.EVENT_NAME],
        eventDescription: data?[DBConstant.EVENT_DESCRIPTION],
        icon: data?[DBConstant.EVENT_ICON],        
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      DBConstant.CATERER_ID: catererId,
      DBConstant.EVENT_MASTER_ID: eventMasterId,
      DBConstant.EVENT_NAME: eventName,
      DBConstant.EVENT_DESCRIPTION: eventDescription??'',
      DBConstant.EVENT_ICON: icon??''  
    };
  }
}