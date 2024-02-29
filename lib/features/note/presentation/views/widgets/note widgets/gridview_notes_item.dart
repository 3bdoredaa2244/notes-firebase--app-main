import 'package:firebase_training/features/note/data/models/note_model.dart';
import 'package:firebase_training/features/note/presentation/manager/get%20note%20cubit/get_note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridViewNoteItem extends StatelessWidget {
  const GridViewNoteItem({super.key, this.onLongPress, required this.note});
  final NoteModel note;
  final void Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(note.note),
              BlocBuilder<GetNoteCubit, GetNoteState>(
                builder: (context, state) {
                  return note.imageUrl != ""
                      ? Image.network(
                          note.imageUrl,
                          height: 90,
                          width: 150,
                          fit: BoxFit.fill,
                        )
                      : const SizedBox(
                          height: 20,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
