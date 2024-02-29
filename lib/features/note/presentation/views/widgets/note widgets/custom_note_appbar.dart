import 'package:flutter/material.dart';

AppBar customNoteAppbar(BuildContext context) {
  return AppBar(
    title: const Text('Notes'),
    centerTitle: true,
    /*actions: [
      IconButton(
          onPressed: () {
            //BlocProvider.of<SignOutCubit>(context).signOut();
          },
          icon: const Icon(Icons.exit_to_app))
    ],*/
  );
}
