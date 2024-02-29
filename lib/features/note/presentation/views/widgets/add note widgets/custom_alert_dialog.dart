import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../filter/presentation/manager/pick_image_cubit/pick_image_cubit.dart';

customAlertDialog(BuildContext context) {
  return AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await BlocProvider.of<PickImageCubit>(context).pickImage();
                Navigator.pop(context);
              },
              child: const Text('pick image')),
          ElevatedButton(
              onPressed: () async {
                await BlocProvider.of<PickImageCubit>(context).captureImage();
                Navigator.pop(context);
              },
              child: const Text('capture image')),
        ],
      ),
    ),
  );
}
