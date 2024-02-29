import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:firebase_training/features/home/presentation/manager/message%20cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/add folder/add_folder_view_body.dart';

class AddFolderView extends StatefulWidget {
  const AddFolderView({super.key});

  @override
  State<AddFolderView> createState() => _AddFolderViewState();
}

class _AddFolderViewState extends State<AddFolderView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add folder'),
        centerTitle: true,
      ),
      body: BlocListener<MessageCubit, MessageState>(
        listener: (context, state) {
          if (state is MessageSuccess) {
            customToast(message: 'success');
          } else if (state is MessageFailure) {
            customToast(
                backgroundColor: Colors.red, message: state.errorMessage);
          }
        },
        child: const AddFolderViewBody(),
      ),
    );
  }
}
