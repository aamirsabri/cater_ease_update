import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/network/apis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constants.dart';
import '../model/caterer_model.dart';

class CatererProvider with ChangeNotifier {
  Caterer? _caterer;
  Caterer? get caterer => _caterer;

  updateCaterer(Caterer caterer) {
    _caterer = caterer;
    notifyListeners();
  }

  Future<void> fetchCatererDetail(String catererId) async {
    Caterer caterer;
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    catererId = catererId ??
        await AppPreference(_sharedPreferences).getValue(COL_CATERER_ID);
    final result = await AppServiceClient.getCatererDetail(catererId);
    if (result is Caterer) {
      caterer = result;
      updateCaterer(caterer);
    }
  }
}
