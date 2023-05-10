import 'package:flutter/cupertino.dart';


import '../model/user_model.dart';

class UserDetailProvider with ChangeNotifier {
   User? _user;
  User? get user => _user;
 
  updateUser(User user) {
    _user = user;
    notifyListeners();
  }
  
}
