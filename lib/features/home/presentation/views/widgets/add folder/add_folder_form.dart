import 'package:firebase_training/core/widgets/custom_button.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/features/home/presentation/manager/add%20category%20cubit/add_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_textformfield.dart';

class AddFolderForm extends StatefulWidget {
  const AddFolderForm({
    super.key,
  });

  @override
  State<AddFolderForm> createState() => _AddFolderFormState();
}

class _AddFolderFormState extends State<AddFolderForm> {
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  TextEditingController folder = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        if (state is AddCategorySuccess) {
          debugPrint(state.successMessage);
          Navigator.of(context).pushReplacementNamed("homepage");
        } else if (state is AddCategoryFailure) {
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
                  hinttext: 'enter folder name',
                  mycontroller: folder,
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
                title: 'Add folder',
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    BlocProvider.of<AddCategoryCubit>(context)
                        .addCategory(folder);
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
