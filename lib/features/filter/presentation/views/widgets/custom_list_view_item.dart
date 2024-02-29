import 'package:firebase_training/features/filter/data/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomListviewItem extends StatelessWidget {
  const CustomListviewItem({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          userData.name,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          '${userData.age}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: Text(
          r'$' '${userData.money}',
          style: const TextStyle(fontSize: 18, color: Colors.red),
        ),
      ),
    );
  }
}
