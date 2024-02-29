import 'package:flutter/material.dart';

import 'widgets/update category/update_category_view_body.dart';

class UpdateCategoryView extends StatelessWidget {
  const UpdateCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add folder'),
        centerTitle: true,
      ),
      body: const UpdateCategoryViewBody(),
    );
  }
}
