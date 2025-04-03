import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String USER_PSWD = "password";

class Constants {
  Constants();

  Constants._privateConstructor();

  static final Constants instance = Constants._privateConstructor();


  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }


  displayToastmessage(BuildContext context, String strMessage) {
    MotionToast.error(
      height: 45,
      width: 300,
      description: Text(strMessage),
      animationCurve: Curves.linear,
      borderRadius: 10,
      animationDuration: const Duration(milliseconds: 1),
    ).show(context);
  }

  bool isValidPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}

