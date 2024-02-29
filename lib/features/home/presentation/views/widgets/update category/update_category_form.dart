import 'package:firebase_training/core/widgets/custom_button.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:firebase_training/features/home/presentation/manager/update%20category%20cubit/update_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_textformfield.dart';

class UpdateCategoryForm extends StatefulWidget {
  const UpdateCategoryForm({
    super.key,
  });
  @override
  State<UpdateCategoryForm> createState() => _UpdateCategoryFormState();
}

class _UpdateCategoryFormState extends State<UpdateCategoryForm> {
  late AutovalidateMode? autovalidateMode;
  late TextEditingController category;
  late GlobalKey<FormState> formState;
  @override
  void initState() {
    category = TextEditingController(
        text: BlocProvider.of<UpdateCategoryCubit>(context).oldName);
    autovalidateMode = AutovalidateMode.disabled;
    formState = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCategoryCubit, UpdateCategoryState>(
      listener: (context, state) {
        if (state is UpdateCategorySuccess) {
          customToast(message: state.successMessage);
          Navigator.of(context).pushReplacementNamed("homepage");
        } else if (state is UpdateCategoryFailure) {
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
                  mycontroller: category,
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
                    BlocProvider.of<UpdateCategoryCubit>(context).name =
                        category;
                    BlocProvider.of<UpdateCategoryCubit>(context)
                        .updateCategory();
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
