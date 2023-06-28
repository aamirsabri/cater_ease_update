import 'package:android_id/android_id.dart';
import 'package:flutter/services.dart';

import '../network/error_handling.dart';
import '../network/failure.dart';

class DeviceInfo {
  // static Future<dynamic?> getUniqueDeviceId() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  //   dynamic identifier;
  //   try {
  //     if (Platform.isAndroid) {
  //       var build = await deviceInfoPlugin.androidInfo;
  //       identifier = build.androidId;
  //       return identifier;
  //     }
  //   } on PlatformException {
  //     //retun failure object
  //     return Failure(
  //         ResponseCode.PERMISSION_IMEI, ResponseMessage.PERMISSION_IMEI);
  //   }
  // }

  static Future<dynamic?> getUniqueDeviceId() async {
    const _androidIdPlugin = AndroidId();
    String androidId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
      print("android id" + androidId.toString());
      if (androidId == 'Unknown ID') {
        return Failure(
            ResponseCode.UNKNOWN, "Error while fetching IMEI Number");
      }
      return androidId.toString();
    } on PlatformException {
      return Failure(
          ResponseCode.PERMISSION_IMEI, ResponseMessage.PERMISSION_IMEI);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static Future<dynamic?> getUniqueDeviceId1() async {
    const _androidIdPlugin = AndroidId();
    String androidId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
      print("android id" + androidId.toString());
      if (androidId == 'Unknown ID') {
        return Failure(
            ResponseCode.UNKNOWN, "Error while fetching IMEI Number");
      }
      return androidId.toString();
    } on PlatformException {
      return Failure(
          ResponseCode.PERMISSION_IMEI, ResponseMessage.PERMISSION_IMEI);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
