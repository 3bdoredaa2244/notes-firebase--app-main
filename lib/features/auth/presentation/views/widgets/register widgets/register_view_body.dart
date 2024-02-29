import 'package:firebase_training/features/auth/presentation/views/widgets/login%20widgets/custom_another_option_text.dart';
import 'package:flutter/material.dart';
import 'custom_register_form.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CustomRegisterForm(),
            CustomAnotherAuthOption(
                onTap: () {},
                authMessage: "Have An Account ? ",
                authOptionName: "Login")
          ],
        ),
      ),
    );
  }
}




/*myauth.setConfig(
                          appEmail: "contact@hdevcoder.com",
                          appName: "Email OTP",
                          userEmail: email.text,
                          otpLength: 4,
                          otpType: OTPType.digitsOnly);
                      if (await myauth.sendOTP() == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                        ));
                        Navigator.of(context).pushReplacementNamed('otpscreen',
                            arguments: myauth);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                        ));
                      }*/