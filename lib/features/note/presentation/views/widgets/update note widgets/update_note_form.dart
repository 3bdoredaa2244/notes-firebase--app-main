import 'package:firebase_training/core/widgets/custom_button.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_textformfield.dart';
import '../../../manager/update note cubit/update_note_cubit.dart';

class UpdateNoteForm extends StatefulWidget {
  const UpdateNoteForm({
    super.key,
  });
  @override
  State<UpdateNoteForm> createState() => _UpdateNoteFormState();
}

class _UpdateNoteFormState extends State<UpdateNoteForm> {
  late AutovalidateMode? autovalidateMode;
  late TextEditingController note;
  late GlobalKey<FormState> formState;
  @override
  void initState() {
    note = TextEditingController(
        text: BlocProvider.of<UpdateNoteCubit>(context).oldNote);
    autovalidateMode = AutovalidateMode.disabled;
    formState = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateNoteCubit, UpdateNoteState>(
      listener: (context, state) {
        if (state is UpdateNoteSuccess) {
          customToast(message: state.successMessage);
          Navigator.of(context).pushReplacementNamed("note");
        } else if (state is UpdateNoteFailure) {
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
                  hinttext: 'enter new note',
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
                title: 'Update Category',
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    BlocProvider.of<UpdateNoteCubit>(context).note = note;
                    BlocProvider.of<UpdateNoteCubit>(context).updateNote();
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
