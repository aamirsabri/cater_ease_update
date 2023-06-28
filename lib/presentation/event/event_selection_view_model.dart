<<<<<<< HEAD
import 'package:cater_ease/model/response.dart';
import 'package:cater_ease/network/apis.dart';
import 'package:flutter/material.dart';

class EventSelectionViewModel {
  BuildContext context;
  EventSelectionViewModel(this.context);

  Future<dynamic> getEventMasters(String catererId) async {
    final result = await AppServiceClient.getEventMaster(catererId);
    return result;
  }
=======
class EventSelectionViewModel {
  EventSelectionViewModel();
>>>>>>> bfd48b135bf2963e39453c8e2ecb7a31db992a55
}
