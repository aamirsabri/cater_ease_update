import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/model/customer_event_model.dart';
import 'package:cater_ease/model/response.dart';
import 'package:cater_ease/network/apis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCustomerEventViewModel {
  BuildContext context;
  NewCustomerEventViewModel(this.context);

  Future<dynamic> createNewCustomerEvent(String eventMasterId, String place,
      DateTime eventStartDate, TimeOfDay eventTime, bool isVIP) async {
    //fetch current catererid, functionid, eventmasterid to insert new customer event
    String catererId =
        Provider.of<CatererProvider>(context, listen: false).caterer!.catererId;
    int? customerId = Provider.of<CustomerProvider>(context, listen: false)
        .currentCustomer!
        .customerId;
    int? functionId = Provider.of<CustomerProvider>(context, listen: false)
        .currentFunction!
        .functionId;

    CustomerEventModel customerEventModel = CustomerEventModel(
        catererId: catererId,
        functionId: functionId!,
        customerId: customerId!,
        eventMasterId: eventMasterId,
        place: place,
        isVip: isVIP);

    final result =
        await AppServiceClient.createNewCustomerEvent(customerEventModel);
    return result;
  }
}
