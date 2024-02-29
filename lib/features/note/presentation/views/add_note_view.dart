import 'package:flutter/material.dart';

import 'widgets/add note widgets/add_note_view_body.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
        centerTitle: true,
      ),
      body: const AddNoteViewBody(),
    );
  }
}
