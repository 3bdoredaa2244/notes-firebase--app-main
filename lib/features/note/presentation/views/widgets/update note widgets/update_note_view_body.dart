import 'package:flutter/material.dart';

import 'update_note_form.dart';

class UpdateNoteViewBody extends StatelessWidget {
  const UpdateNoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: UpdateNoteForm(),
    );
  }
}
