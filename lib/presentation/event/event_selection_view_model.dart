import 'package:cater_ease/model/response.dart';
import 'package:cater_ease/network/apis.dart';
import 'package:flutter/material.dart';

class EventSelectionViewModel {
  BuildContext context;
  EventSelectionViewModel(this.context);

  Future<dynamic> getEventMasters(String catererId) async {
    print("caterer id: " + catererId);
    final result = await AppServiceClient.getEventMaster(catererId);
    return result;
  }
}
