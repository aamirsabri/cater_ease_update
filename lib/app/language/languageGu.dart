import 'language.dart';

class LanguageGu extends Languages {
  @override
  String get appName => "કેટરીંગ ઈઝી";

  @override
  String? get loginLabel => "સાઇન ઇન";

  @override
  String get appTag => "તમારો કેટરિંગ પાર્ટનર";

  @override
  String get usernameHint => "તમારો નામ";
  @override
  String get passwordHint => "તમારો પાસવર્ડ";
  @override
  String get registerLabel => "સાઇન અપ";
  @override
  String get emailHint => "તમારો ઈમેલ";
  @override
  String get confirmPasswordHint => "કન્ફર્મ પાસવર્ડ";
  @override
  String get mobileHint => "તમારો મોબાઈલ નંબર";

  @override
  String get successfullySignedUp => "અભિનંદન! તમે સફળતાપૂર્વક સાઇન અપ કર્યું";
  
  @override
  // TODO: implement fullNameHint
  String get fullNameHint => "તમારો પૂરું નામ";
  
  @override
  // TODO: implement catererName
  String get catererName => "પેઢીનું નામ";
  
  @override
  // TODO: implement placeNameHint
  String get placeNameHint => "શહર/ગામનું નામ";
  
  @override
  // TODO: implement successfullySignedIn
  String get successfullySignedIn => "અભિનંદન! તમે સફળતાપૂર્વક સાઇન ઇન કર્યું";
  
}
