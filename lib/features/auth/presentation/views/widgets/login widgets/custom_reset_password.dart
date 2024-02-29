import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/reset password cubit/reset_password_cubit.dart';

class CustomResetPassword extends StatelessWidget {
  const CustomResetPassword({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          customAwesomeDialog(
              context: context,
              titleText: 'sending successful',
              contentText:
                  "check your email's inbox to change email's password",
              color: Colors.green,
              dialogType: DialogType.success);
        } else if (state is ResetPasswordEmpty) {
          customAwesomeDialog(
            context: context,
            titleText: 'Empty',
            contentText: "you should input your email first",
            color: Colors.red,
          );
        } else if (state is ResetPasswordFailure) {
          customAwesomeDialog(
            context: context,
            titleText: 'Error',
            contentText: state.error,
            color: Colors.red,
          );
        }
      },
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          alignment: Alignment.topRight,
          child: const Text(
            "Forgot Password ?",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
