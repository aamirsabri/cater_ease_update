import 'package:cater_ease/app/database/dbhelper.dart';
import 'package:cater_ease/app/firebase/firebase_constants.dart';
import 'package:cater_ease/app/functions.dart';
import 'package:cater_ease/domain/caterer_provider.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/model/customer_function_model.dart';
import 'package:cater_ease/network/networkinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';

class NewFunctionNewViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  BuildContext context;
  NewFunctionNewViewModel(this.context);
  Future<String> saveNewCustomer(
      String name, String? email, String mobile, String? address) async {
    EasyLoading.show();
    String result = "something went wrong";
    try {
      if (await NetworkInfo.isConnected()) {
        Customer customer = Customer(
            customerName: name, mobile: mobile, email: email, address: address);
        print(customer.toMap().toString());
        if (await NetworkInfo.isConnected()) {
          final customerId = await DBHelper.insertCustomer(customer);
          if (customerId is int) {
            customer.customerId = int.parse(customerId.toString());
            await Provider.of<CustomerProvider>(context, listen: false)
                .updateCustomer(customer);
            return "success";
          } else {
            return "error while inserting new customer";
          }
        } else {
          return "check your internet connection";
        }
      } else {
        return "check your network info";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> saveNewFunction(
      int customerId,
      String functionName,
      String? address,
      DateTime startDate,
      DateTime? endDate,
      String familyName,
      String functionType) async {
    print(
        "${customerId} ${functionName} ${address} ${startDate.toString()} ${endDate.toString()} ${familyName}");
    EasyLoading.show();
    String result = "something went wrong";
    try {
      if (await NetworkInfo.isConnected()) {
        final catererId = Provider.of<CatererProvider>(context, listen: false)
            .caterer!
            .catererId;
        CustomerFunction newFunction = CustomerFunction(
            catererId: catererId,
            customerId: customerId,
            functionName: functionName,
            address: address,
            startDate: startDate,
            endDate: endDate,
            familyName: familyName,
            functionType: functionType);
        print(newFunction.toMap().toString());

        final functionId = await DBHelper.insertCustomerFunction(newFunction);
        if (functionId is int) {
          newFunction.functionId = int.parse(functionId.toString());
          await Provider.of<CustomerProvider>(context, listen: false)
              .updateCustomerFunction(newFunction);
          return "success";
        } else {
          return "error while inserting new customer";
        }
      } else {
        return "check your network info";
      }
    } catch (e) {
      print("error");
      return e.toString();
    }
  }

  Future<dynamic> getFunctionSuggesions(String catererId) async {
    EasyLoading.show();
    List<String> functionTypes = [];
    try {
      if (await NetworkInfo.isConnected()) {
        DocumentReference funcTypesRef = await _firestore
            .collection(Collection.FUNCTION_TYPES)
            .doc(catererId);
        await funcTypesRef.get().then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          functionTypes =
              List<String>.from(data[Field.FUNCTION_TYPES]) as List<String>;
          print("function type " + functionTypes.toString());
        });
        return functionTypes;
      } else {
        return "check your internet connection";
      }
    } on FirebaseException catch (e) {
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getAllConsumers() async {
    Map<String, Customer> customers = {};
    EasyLoading.show();
    List<String> functionTypes = [];
    try {
      if (await NetworkInfo.isConnected()) {
        var res = await DBHelper.getAllCustomers();
        EasyLoading.dismiss();
        print("customrs " + res.keys.toString());

        return res;
      } else {
        EasyLoading.showError("check your internet connection");
        return {};
      }
    } catch (e) {
      print("error while fetching all consumers " + e.toString());
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      return {};
    }
  }
}
