import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import 'widgets/test_view_body.dart';

class TestView extends StatelessWidget {
  const TestView({super.key, required this.usersData});

  final List<UserModel> usersData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TestViewBody(
        usersData: usersData,
      ),
    );
  }
}
