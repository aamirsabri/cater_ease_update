import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/model/customer_function_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constants.dart';
import '../model/caterer_model.dart';
import '../model/customer_model.dart';

class CustomerProvider with ChangeNotifier{
  Customer? _currentCustomer;
  Customer? get currentCustomer => _currentCustomer;
  CustomerFunction? _customerFunction;
  CustomerFunction? get customerFunction => _customerFunction;

  updateCustomer(Customer customer) {
    _currentCustomer = customer;
    notifyListeners();
  }

  updateCustomerFunction(CustomerFunction customerFunction){
    _customerFunction = customerFunction;
    notifyListeners();
  }

  // Future<void> fetchCatererDetail(String catererId) async{
    
  //   SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  //   catererId = catererId??await AppPreference(_sharedPreferences).getValue(COL_CATERER_ID);
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   Caterer caterer = await _firestore.collection("caterers").doc(catererId).get().
  //     then((DocumentSnapshot<Map<String,dynamic>> doc){
  //       return Caterer.fromFirestore(doc);
  //   });
  //   updateCaterer(caterer);
  // }
  
}