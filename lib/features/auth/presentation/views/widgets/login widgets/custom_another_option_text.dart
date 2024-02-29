import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomAnotherAuthOption extends StatelessWidget {
  const CustomAnotherAuthOption({
    super.key,
    required this.onTap,
    required this.authMessage,
    required this.authOptionName,
  });
  final void Function()? onTap;
  final String authMessage;
  final String authOptionName;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
          text: authMessage,
        ),
        TextSpan(
            text: authOptionName,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap),
      ])),
    );
  }
}
