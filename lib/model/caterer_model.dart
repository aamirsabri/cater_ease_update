import 'package:cater_ease/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Caterer{
  String catererId;
  String catererName;
  String email;
  String? logo;
  String? mobile;
  String place;
  bool isActive;

  Caterer({
    required this.catererId,
    required this.catererName,
    required this.email,
    this.logo,
    required this.mobile,
    required this.place,
    required this.isActive
    });

  factory Caterer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
    
  ) {
      final data = snapshot.data();
      return Caterer(
        catererId: data?[COL_CATERER_ID],
        catererName: data?[COL_CATERER_NAME],
        email: data?[COL_EMAIL],
        logo: data?[COL_LOGO],
        mobile: data?[COL_MOBILE],
        place: data?[COL_PLACE],
        isActive: data?[COL_IS_ACTIVE]
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      COL_CATERER_ID: catererId,
      COL_CATERER_NAME: catererName,
      COL_EMAIL: email,
      COL_LOGO: logo??'',
      COL_MOBILE: mobile??'',
      COL_PLACE:place,
      COL_IS_ACTIVE:isActive??false,
    };
  }
}