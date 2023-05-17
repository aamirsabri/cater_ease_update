import 'package:cater_ease/app/database/dbhelper.dart';
import 'package:cater_ease/app/firebase/firebase_constants.dart';
import 'package:cater_ease/domain/customer_provider.dart';
import 'package:cater_ease/network/networkinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';

class NewFunctionNewViewModel{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  BuildContext context;
  NewFunctionNewViewModel(this.context);
  Future<String> saveNewCustomer(String name,String? email,String mobile,String? address) async{
  EasyLoading.show();
  String result = "something went wrong";
    try{
      if(await NetworkInfo.isConnected()){
        Customer customer = Customer(customerName: name, mobile: mobile,email: email,address: address);
      if(await NetworkInfo.isConnected()){
        await DBHelper.insertCustomer(customer);
        await Provider.of<CustomerProvider>(context,listen: false).updateCustomer(customer);
        return "success";
      }else{
        return "check your internet connection";
      }
      }else{
        return "check your network info";
      }
      
    }catch(e){
      return e.toString();
    }
  }
  Future<dynamic> getFunctionSuggesions(String catererId) async{
    EasyLoading.show();
    List<String> functionTypes = [];
    try{
      if(await NetworkInfo.isConnected()){
        DocumentReference funcTypesRef = await _firestore.collection(Collection.FUNCTION_TYPES).doc(catererId);
        await funcTypesRef.get().then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String,dynamic>;
          functionTypes = List<String>.from(data[Field.FUNCTION_TYPES]) as List<String>;
          print("function type " + functionTypes.toString());
        }); 
        return functionTypes;
      }else{
        return "check your internet connection";
      }
    } on FirebaseException catch(e){
      return e.code.toString();
      
    }catch(e){
      return e.toString();
    }
  }
}