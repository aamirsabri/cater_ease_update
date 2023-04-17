import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_EMP_ID = "PREF_KEY_EMP_ID";

class AppPreference {
  SharedPreferences _sharedPreferences;
  // AppP(){
  //   this._sharedPreferences = SharedPreferences.getInstance();
  // }
  AppPreference(this._sharedPreferences);
  Future<String?> getEmpId() async {
    String? empId = _sharedPreferences.getString(PREF_KEY_EMP_ID);
    if (empId == null || empId.isEmpty) {
      return null;
    } else {
      return empId;
    }
  }

  Future setEmpId(String empId) async {
    await _sharedPreferences.setString(PREF_KEY_EMP_ID, empId);
  }
}
