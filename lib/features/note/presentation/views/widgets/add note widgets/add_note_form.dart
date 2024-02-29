import 'package:firebase_training/core/widgets/custom_button.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/features/filter/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:firebase_training/features/note/data/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_textformfield.dart';
import '../../../../../../core/widgets/custom_toast.dart';
import '../../../../../filter/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import '../../../manager/add note cubit/add_note_cubit.dart';
import 'custom_alert_dialog.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  TextEditingController note = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNoteCubit, AddNoteState>(
      listener: (context, state) {
        if (state is AddNoteSuccess) {
          debugPrint(state.successMessage);
          Navigator.of(context).pushReplacementNamed('note');
        } else if (state is AddNoteFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: state.toString(),
              color: Colors.red);
        }
      },
      child: Form(
        autovalidateMode: autovalidateMode,
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextForm(
                  maxLines: 5,
                  hinttext: 'enter your note',
                  mycontroller: note,
                  textFormFieldvalidator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "can't be empty";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Add note',
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    BlocProvider.of<AddNoteCubit>(context).addNote(
                        note: NoteModel(
                            note: note.text,
                            imageUrl: BlocProvider.of<UploudImageCubit>(context)
                                    .url ??
                                ""));
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocListener<PickImageCubit, PickImageState>(
                listener: (context, state) {
                  var get = BlocProvider.of<PickImageCubit>(context);
                  if (state is PickImageSuccess) {
                    BlocProvider.of<UploudImageCubit>(context).uploadAndDowload(
                        file: get.file!, baseName: get.baseName!);
                    customToast(message: 'success');
                  } else if (state is PickImageFailure) {
                    customToast(
                        backgroundColor: Colors.red,
                        message: state.errorMessage);
                  }
                },
                child: CustomButton(
                  title: 'Add image',
                  onPressed: () {
                    showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return customAlertDialog(context);
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
