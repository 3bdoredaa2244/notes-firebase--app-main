import 'package:flutter/material.dart';
import 'custom_another_option_text.dart';
import 'custom_google_auth_button.dart';
import 'custom_login_form.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CustomLoginForm(),
            Container(height: 20),
            const CustomGoogleAuthButton(),
            CustomAnotherAuthOption(
              authMessage: "Don't Have An Account ? ",
              authOptionName: "Register",
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
            )
          ],
        ),
      ),
    );
  }
}
