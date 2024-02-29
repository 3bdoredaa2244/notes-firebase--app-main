import 'package:firebase_training/features/home/presentation/views/widgets/update%20category/update_category_form.dart';
import 'package:flutter/material.dart';

class UpdateCategoryViewBody extends StatelessWidget {
  const UpdateCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: UpdateCategoryForm(),
    );
  }
}
