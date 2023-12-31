import 'package:cater_ease/app/app_pref.dart';
import 'package:cater_ease/model/caterer_model.dart';
import 'package:cater_ease/model/customer_event.dart';
import 'package:cater_ease/model/customer_event_model.dart';
import 'package:cater_ease/model/customer_function_model.dart';
import 'package:cater_ease/model/customer_model.dart';
import 'package:cater_ease/model/requests.dart';
import 'package:cater_ease/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/constants.dart';

import '../model/user_model.dart';
import 'error_handling.dart';
import 'failure.dart';
import 'networkinfo.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AppServiceClient {
  static Future<dynamic> getRawHttp(url, argument) async {
    try {
      print("url" + url.toString());
      print("json encode " + convert.jsonEncode(argument));
      if (!await NetworkInfo.isConnected()) {
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      }
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: convert.jsonEncode(argument),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response in rawhttp " + response.body.toString());
        final jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        print("json response" + jsonResponse.toString());
        // print("respose of url " + jsonResponse['consumer'].toString());
        return jsonResponse;
      } else {
        print(response.statusCode);
        print("when error " + response.body.toString());
        return ErrorHandler.handleError(response.statusCode);
      }
    } catch (e) {
      print("in erirr " + e.toString());
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> getCatererDetail(String catererId) async {
    try {
      var url = Uri.parse(Constant.testBaseUrl + Constant.getCaterer);
      Map<String, dynamic> argument = {COL_CATERER_ID: catererId};
      var response = await getRawHttp(url, argument);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      if (response['status'] == 200) {
        print("response messege " + response['message']);
        return Caterer.fromMap(response[JSON_OBJECT_CATERER]);
      } else {
        print("response messege else " + response['message']);
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> createNewCustomer(Customer customer) async {
    try {
      var url = Uri.parse(Constant.testBaseUrl + Constant.newCustomer);
      var response = await getRawHttp(url, customer.toMap());
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      if (response['status'] == 200) {
        return response[COL_CUSTOMER_ID];
      } else {
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> createNewCustomerEvent(
      CustomerEventModel customerEventModel) async {
    try {
      var url = Uri.parse(Constant.baseUrl + Constant.newCustomerEvent);
      var response = await getRawHttp(url, customerEventModel.toMap());
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      if (response['status'] == 200) {
        return response['status'];
      } else {
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> getAllCompanyCodes() async {
    try {
      List<String> companyCodes = [];
      var url = Uri.parse(Constant.testBaseUrl + Constant.testGetCompanyIds);
      var response = await getRawHttp(url, null);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      if (response['status'] == 200) {
        return response['company_codes'];
      } else {
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> getEventMaster(String catererId) async {
    List events = [];
    List eventMasters = [];
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final eventMasterRef = await firebaseFirestore
          .collection(FirebaseConstants.CATERER_COLLECTION)
          .doc(catererId)
          .collection(FirebaseConstants.EVENT_MASTER_COLLECTION)
          .get();
      if (eventMasterRef.docs.isNotEmpty) {
        events.addAll(eventMasterRef.docs);

        events.forEach((event) async {
          var data = event.data() as Map<String, dynamic>;
          eventMasters.add(
            EventMasterViewModel(
                eventMasterId: event.id,
                eventName: event[DBConstant.EVENT_NAME],
                imageUrl: event[DBConstant.EVENT_ICON]),
          );
        });
      }
      return eventMasters;
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> signUpUser(SignUpRequest registerRequest) async {
    try {
      var url = Uri.parse(Constant.baseUrl + Constant.registration);
      Map<String, dynamic> argument = registerRequest.toMap();
      var response = await getRawHttp(url, argument);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      if (response['status'] == 200) {
        print("response messege " + response[JSON_OBJECT_FUNCTIONS]);
        return response[JSON_OBJECT_FUNCTIONS].map((function) {
          return CustomerFunction.fromMap(function);
        }).toList();
      } else {
        print("response messege else " + response['message']);
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> login(LoginRequest login) async {
    try {
      var url = Uri.parse(Constant.testBaseUrl + Constant.login);
      Map<String, dynamic> argument = login.toMap();
      var response = await getRawHttp(url, argument);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      print("status   sssss : " + response['status'].toString());
      if (response['status'] == 200) {
        print("code 200");
        // print("USER " + response[JSON_OBJECT_USER].toString());
        return User.fromMap(response[JSON_OBJECT_USER]);
      } else {
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  static Future<dynamic> getPendingFutureFunctions(String catererId) async {
    List functions = [];

    try {
      var url = Uri.parse(Constant.testBaseUrl + Constant.getFutureFunctions);
      Map<String, dynamic> argument = {CATERER_ID: catererId};
      var response = await getRawHttp(url, argument);
      if (response is Failure) {
        return response;
      }
      if (response == null) {
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      }
      print("status   sssss : " + response['status'].toString());
      if (response['status'] == 200) {
        print("code 200");
        // print("USER " + response[JSON_OBJECT_USER].toString());
        return User.fromMap(response[JSON_OBJECT_USER]);
      } else {
        if (response['status'] is int) {
          return Failure(response['status'], response['message']);
        } else {
          return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
        }
      }
    } catch (e) {
      return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }

  // static Future<dynamic> getAllCompanyMaster() async {
  //   try {
  //     var url = Uri.parse(Constant.baseUrl + Constant.getAllCompanies);
  //     var response = await getRawHttp(url, null);
  //     if (response is Failure) {
  //       return response;
  //     }
  //     if (response == null) {
  //       return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
  //     }
  //     if (response['status'] == 200) {
  //       return response[JSON_OBJECT_COMPANIES].map((company) {

  //       }).toList();
  //     } else {
  //       if (response['status'] is int) {
  //         return Failure(response['status'], response['message']);
  //       } else {
  //         return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
  //       }
  //     }
  //   } catch (e) {
  //     return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
  //   }
  // }
}
