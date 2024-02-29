import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:firebase_training/features/filter/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:firebase_training/features/filter/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import 'custom_listview.dart';

class TestViewBody extends StatelessWidget {
  const TestViewBody({super.key, required this.usersData});
  final List<UserModel> usersData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: CustomListview(
              usersData: usersData,
            ),
          ),
          BlocConsumer<PickImageCubit, PickImageState>(
            listener: (context, state) {
              var get = BlocProvider.of<PickImageCubit>(context);
              if (state is PickImageSuccess) {
                BlocProvider.of<UploudImageCubit>(context)
                    .uploadAndDowload(file: get.file!, baseName: get.baseName!);
                customToast(message: 'success');
              } else if (state is PickImageFailure) {
                customToast(
                    backgroundColor: Colors.red, message: state.errorMessage);
              }
            },
            builder: (context, state) {
              return BlocConsumer<UploudImageCubit, UploudImageState>(
                builder: (context, state) {
                  return state is UploudImageSuccess
                      ? Image.network(
                          BlocProvider.of<UploudImageCubit>(context).url!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        )
                      : const SizedBox(
                          height: 20,
                        );
                },
                listener: (BuildContext context, UploudImageState state) {
                  if (state is UploudImageFailure) {
                    customToast(
                        backgroundColor: Colors.red,
                        message: state.errorMessage);
                  }
                },
              );
            },
          ),
          ElevatedButton(
              onPressed: () async {
                await BlocProvider.of<PickImageCubit>(context).pickImage();
              },
              child: const Text('pick image')),
          ElevatedButton(
              onPressed: () async {
                await BlocProvider.of<PickImageCubit>(context).captureImage();
              },
              child: const Text('capture image')),
        ],
      ),
    );
  }
}
