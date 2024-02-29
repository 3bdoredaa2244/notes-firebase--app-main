import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:firebase_training/features/auth/presentation/manager/login%20cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/reset password cubit/reset_password_cubit.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../custom_logo_auth.dart';
import '../../../../../../core/widgets/custom_textformfield.dart';
import '../../../../../../core/widgets/custom_awesome_dialog.dart';
import 'custom_reset_password.dart';

class CustomLoginForm extends StatefulWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: state.errorMessage,
              color: Colors.red);
        } else if (state is LoginSuccess) {
          customToast(message: 'login successfully ');
          Navigator.of(context).pushReplacementNamed("homepage");
        }
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              const CustomLogoAuth(),
              Container(height: 20),
              const Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                hinttext: "ُEnter Your Email",
                mycontroller: email,
                textFormFieldvalidator: (String? input) {
                  if (input?.isEmpty ?? true) {
                    return 'enter the email ';
                  } else {
                    return null;
                  }
                },
              ),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                hinttext: "ُEnter Your Password",
                mycontroller: password,
                textFormFieldvalidator: (String? input) {
                  if (input?.isEmpty ?? true) {
                    return 'enter the password ';
                  } else {
                    return null;
                  }
                },
              ),
              CustomResetPassword(
                onTap: () async {
                  BlocProvider.of<ResetPasswordCubit>(context).email =
                      email.text;
                  BlocProvider.of<ResetPasswordCubit>(context).resetPassword();
                },
              ),
              CustomButton(
                  title: "login",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context)
                          .validateLogin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  }),
            ],
          ),
        );
      },
    );
  }
}
