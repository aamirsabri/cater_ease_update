import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String? get loginLabel;
  // String get appName;
  String get appTag;
  String get usernameHint;
  String get passwordHint;
  String get registerLabel;
  String get emailHint;
  String get confirmPasswordHint;
  String get placeNameHint;
  String get mobileHint;
  String get successfullySignedUp;
  String get successfullySignedIn;
  String get fullNameHint;
  String get catererName;

}
