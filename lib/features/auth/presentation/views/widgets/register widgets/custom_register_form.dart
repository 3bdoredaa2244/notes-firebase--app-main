import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/register cubit/register_cubit.dart';
import '../custom_logo_auth.dart';
import '../../../../../../core/widgets/custom_textformfield.dart';

class CustomRegisterForm extends StatefulWidget {
  const CustomRegisterForm({
    super.key,
  });

  @override
  State<CustomRegisterForm> createState() => _CustomRegisterFormState();
}

class _CustomRegisterFormState extends State<CustomRegisterForm> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: state.errorMessage);
        } else if (state is RegisterSuccess) {
          customToast(message: state.successMessage);
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
              const Text("SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("SignUp To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                hinttext: "ُEnter Your username",
                mycontroller: username,
                textFormFieldvalidator: (String? input) {
                  if (input?.isEmpty ?? true) {
                    return 'enter the username ';
                  } else {
                    return null;
                  }
                },
              ),
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
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              CustomButton(
                  title: "SignUp",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterCubit>(context)
                          .validateRegister(email, password);
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
