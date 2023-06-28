import 'package:cater_ease/app/constants.dart';

class EventMasterViewModel {
  String eventMasterId;
  String eventName;
  String? imageUrl;
  EventMasterViewModel(
      {required this.eventMasterId, required this.eventName, this.imageUrl});

  factory EventMasterViewModel.fromMap(Map<String, dynamic> data) {
    return EventMasterViewModel(
        eventMasterId: data?[DBConstant.EVENT_MASTER_ID],
        eventName: data?[DBConstant.EVENT_NAME],
        imageUrl: data?[DBConstant.EVENT_ICON]);
  }

  Map<String, dynamic> toMap() {
    return {
      DBConstant.EVENT_MASTER_ID: eventMasterId,
      DBConstant.EVENT_NAME: eventName,
      DBConstant.EVENT_ICON: imageUrl.toString,
    };
  }
}
