import 'package:firebase_training/features/filter/presentation/views/test_view.dart';
import 'package:firebase_training/features/home/presentation/manager/sign%20out%20cubit/sign_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../filter/presentation/manager/test cubit/test_cubit.dart';

AppBar customHomeAppbar(BuildContext context) {
  return AppBar(
    title: const Text('Firebase install'),
    centerTitle: true,
    leading: IconButton(
        onPressed: () async {
          BlocProvider.of<TestCubit>(context).test().then((usersData) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return TestView(usersData: usersData);
            }));
          });
        },
        icon: const Icon(Icons.filter)),
    actions: [
      IconButton(
          onPressed: () {
            BlocProvider.of<SignOutCubit>(context).signOut();
          },
          icon: const Icon(Icons.exit_to_app))
    ],
  );
}
