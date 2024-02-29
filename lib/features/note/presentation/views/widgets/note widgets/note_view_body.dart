import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/delete note/delete_note_cubit.dart';
import '../../../manager/get note cubit/get_note_cubit.dart';
import '../../../manager/update note cubit/update_note_cubit.dart';
import 'gridview_notes_item.dart';

class NoteViewBody extends StatefulWidget {
  const NoteViewBody({super.key});

  @override
  State<NoteViewBody> createState() => _NoteViewBodyState();
}

class _NoteViewBodyState extends State<NoteViewBody> {
  @override
  void initState() {
    BlocProvider.of<GetNoteCubit>(context).getNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetNoteCubit, GetNoteState>(
      listener: (context, state) {
        if (state is GetNoteFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: state.error,
              color: Colors.red);
        }
      },
      builder: (context, state) {
        return DeleteNoteItem(
          state: state,
        );
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////

class DeleteNoteItem extends StatelessWidget {
  const DeleteNoteItem({
    super.key,
    required this.state,
  });
  final GetNoteState state;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteNoteCubit, DeleteNoteState>(
      listener: (deleteContext, deleteState) {
        if (deleteState is DeleteNoteSuccess) {
          //Navigator.of(context).pop;
          customToast(message: 'Deleting item seccessfully');
        } else if (deleteState is DeleteNoteFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: 'Error occured when try to delete item,try again');
        }
      },
      builder: (deleteContext, deleteState) {
        return deleteState is DeleteNoteLoading || state is GetNoteLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  itemCount:
                      BlocProvider.of<GetNoteCubit>(context).notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 160),
                  itemBuilder: (BuildContext context, int index) {
                    if (index <
                        BlocProvider.of<GetNoteCubit>(context).notes.length) {
                      return GridViewNoteItem(
                        onLongPress: () {
                          customAwesomeDialog(
                              context: context,
                              titleText: 'question',
                              contentText:
                                  'Are you want to delete or update it?',
                              dialogType: DialogType.question,
                              color: Colors.amber,
                              cancelText: 'Delete',
                              okText: 'Update',
                              btnOkOnPress: () {
                                BlocProvider.of<UpdateNoteCubit>(context)
                                        .branchPath =
                                    BlocProvider.of<GetNoteCubit>(context)
                                        .notes[index]
                                        .id;
                                BlocProvider.of<UpdateNoteCubit>(context)
                                        .oldNote =
                                    BlocProvider.of<GetNoteCubit>(context)
                                        .notes[index]
                                        .note;
                                Navigator.of(context)
                                    .pushReplacementNamed("updateNote");
                              },
                              btnCancelOnPress: () {
                                if (BlocProvider.of<GetNoteCubit>(context)
                                        .notes[index]
                                        .imageUrl !=
                                    "") {
                                  FirebaseStorage.instance.refFromURL(
                                      BlocProvider.of<GetNoteCubit>(context)
                                          .notes[index]
                                          .imageUrl);
                                }
                                BlocProvider.of<DeleteNoteCubit>(context)
                                    .deleteNote(
                                        BlocProvider.of<GetNoteCubit>(context)
                                            .mainPath,
                                        BlocProvider.of<GetNoteCubit>(context)
                                            .notes[index]
                                            .id!);
                                BlocProvider.of<GetNoteCubit>(context)
                                    .getNote();
                              });
                        },
                        note:
                            BlocProvider.of<GetNoteCubit>(context).notes[index],
                      );
                    } else {
                      return null; // or return a fallback widget if needed
                    }
                  },
                ),
              );
      },
    );
  }
}
