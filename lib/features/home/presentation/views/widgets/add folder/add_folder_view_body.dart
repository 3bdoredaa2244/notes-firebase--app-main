import 'package:flutter/material.dart';

import 'add_folder_form.dart';

class AddFolderViewBody extends StatelessWidget {
  const AddFolderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: AddFolderForm(),
    );
  }
}
