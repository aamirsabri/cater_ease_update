import 'language.dart';

class LanguageEn extends Languages {
  @override
  String get appName => "Cate Ease";

  @override
  String? get loginLabel => "Sign In";

  @override
  String get appTag => "Your Event, Under Control";

  @override
  String get usernameHint => "Your Name";
  @override
  String get passwordHint => "Your Password";
  @override
  String get registerLabel => "Sign Up";
  @override
  String get emailHint => "Your Email";
  @override
  String get confirmPasswordHint => "Confirm Password";
  @override
  String get mobileHint => "Your Mobile Number";

  @override
  String get successfullySignedUp => "Congratulation! You Signed Up successfully";
  
  @override
  // TODO: implement fullNameHint
  String get fullNameHint => "Your Full Name";
  
  @override
  // TODO: implement catererName
  String get catererName => "Caterer Name";
  
  @override
  // TODO: implement placeNameHint
  String get placeNameHint => "City Name";
  
  @override
  // TODO: implement successfullySignedIn
  String get successfullySignedIn => "You are successfully signed in.";
}
