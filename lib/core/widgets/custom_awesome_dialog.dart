import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void customAwesomeDialog(
    {required BuildContext context,
    required String titleText,
    required String contentText,
    Color? color,
    void Function()? btnOkOnPress,
    void Function()? btnCancelOnPress,
    DialogType dialogType = DialogType.error,
    String cancelText = 'Cancel',
    String okText = 'Ok'}) {
  AwesomeDialog(
    btnCancelText: cancelText,
    btnOkText: okText,
    context: context,
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    title: titleText,
    desc: contentText,
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: btnCancelOnPress,
    //btnOkIcon: Icons.cancel,
    btnOkColor: color,
  ).show();
}
