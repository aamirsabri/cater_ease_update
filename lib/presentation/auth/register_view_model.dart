import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModelController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BuildContext context;
  RegisterViewModelController(this.context);

  Future<dynamic?> signUpUser(String email, String password) async {
      String result = "Error while Registration!";
      try{
        if(validate(email, password)){
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        result = "success";        
      }else{
        result = "Fields are not valid";
      }
      }catch(e){
      }      
      return result;
      
  }

  bool validate(String email,String password){
    return true;
  }


}
