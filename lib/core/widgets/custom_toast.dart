import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast({required String message, Color backgroundColor = Colors.green}) {
  Fluttertoast.showToast(
      msg: message,
      //toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: Colors.grey[50],
      fontSize: 16.0);
}
