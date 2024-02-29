import 'package:flutter/material.dart';

import 'widgets/note widgets/custom_note_appbar.dart';
import 'widgets/note widgets/note_view_body.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customNoteAppbar(context),
      body: const NoteViewBody(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("addNote");
          }),
    );
  }
}
