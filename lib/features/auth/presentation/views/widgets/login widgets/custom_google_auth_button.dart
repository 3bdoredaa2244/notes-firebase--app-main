import 'package:firebase_training/core/constants.dart';
import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:firebase_training/features/auth/presentation/manager/login%20google%20cubit/login_google_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGoogleAuthButton extends StatelessWidget {
  const CustomGoogleAuthButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginGoogleCubit, LoginGoogleState>(
      listener: (context, state) {
        if (state is LoginGoogleSuccess) {
          customToast(message: 'successfully login with google');
          googleLogin = true;
          Navigator.of(context).pushReplacementNamed("homepage");
        } else if (state is LoginGoogleFailure) {
          customToast(message: state.errorMessage, backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return state is LoginGoogleLoading
            ? const Center(child: CircularProgressIndicator())
            : MaterialButton(
                minWidth: double.infinity,
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.red[700],
                textColor: Colors.white,
                onPressed: () {
                  BlocProvider.of<LoginGoogleCubit>(context).signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Login With Google  "),
                    Image.asset(
                      "assets/images/mainlogo.png",
                      width: 20,
                    )
                  ],
                ));
      },
    );
  }
}
