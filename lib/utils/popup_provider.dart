import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PopupProvider {
  static showFlutterToast({required String msg, Color? color}) {
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color ?? Colors.green,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
    );
  }
}
