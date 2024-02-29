import 'package:flutter/material.dart';

import 'widgets/update note widgets/update_note_view_body.dart';

class UpdateNoteView extends StatelessWidget {
  const UpdateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit note'),
        centerTitle: true,
      ),
      body: const UpdateNoteViewBody(),
    );
  }
}
