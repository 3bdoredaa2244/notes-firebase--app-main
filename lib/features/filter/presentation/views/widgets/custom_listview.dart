import 'package:firebase_training/features/filter/data/models/user_model.dart';
import 'package:flutter/material.dart';

import 'custom_list_view_item.dart';

class CustomListview extends StatelessWidget {
  const CustomListview({super.key, required this.usersData});
  final List<UserModel> usersData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomListviewItem(
          userData: usersData[index],
        );
      },
    );
  }
}
