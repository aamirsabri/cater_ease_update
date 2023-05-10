import 'package:cater_ease/app/app_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constants.dart';
import '../model/caterer_model.dart';

class CatererProvider with ChangeNotifier{
  Caterer? _caterer;
  Caterer? get caterer => _caterer;


  updateCaterer(Caterer caterer) {
    _caterer = caterer;
    notifyListeners();
  }

  fetchCatererDetail(String catererId) async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String catererId = await AppPreference(_sharedPreferences).getValue(COL_CATERER_ID);
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Caterer caterer = await _firestore.collection("caterers").doc(catererId).get().
      then((DocumentSnapshot<Map<String,dynamic>> doc){
        return Caterer.fromFirestore(doc);
    });
    updateCaterer(caterer);
  }
  
}