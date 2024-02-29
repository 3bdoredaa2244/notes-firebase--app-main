import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_training/core/constants.dart';
import 'package:firebase_training/core/widgets/custom_awesome_dialog.dart';
import 'package:firebase_training/core/widgets/custom_toast.dart';
import 'package:firebase_training/features/home/presentation/manager/delete%20category%20cubit/delete_category_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/get%20category%20cubit/get_category_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/sign%20out%20cubit/sign_out_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/update%20category%20cubit/update_category_cubit.dart';
import 'package:firebase_training/features/note/presentation/manager/get%20note%20cubit/get_note_cubit.dart';
import 'package:firebase_training/features/note/presentation/manager/update%20note%20cubit/update_note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../note/presentation/manager/add note cubit/add_note_cubit.dart';
import '../../../manager/message cubit/message_cubit.dart';
import 'gridview_folders_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    BlocProvider.of<GetCategoryCubit>(context).getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCategoryCubit, GetCategoryState>(
      listener: (context, state) {
        if (state is GetCategoryFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: state.error,
              color: Colors.red);
        }
      },
      builder: (context, state) {
        return DeleteCategoryItem(
          state: state,
        );
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////

class DeleteCategoryItem extends StatelessWidget {
  const DeleteCategoryItem({
    super.key,
    required this.state,
  });
  final GetCategoryState state;

  void sendMessageAndReceiveNotification(BuildContext context) async {
    //receiveMessage();
    await BlocProvider.of<MessageCubit>(context).sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
      listener: (deleteContext, deleteState) {
        if (deleteState is DeleteCategorySuccess) {
          //Navigator.of(context).pop;
          customToast(message: 'Deleting item seccessfully');
        } else if (deleteState is DeleteCategoryFailure) {
          customAwesomeDialog(
              context: context,
              titleText: 'Error',
              contentText: 'Error occured when try to delete item,try again');
        }
      },
      builder: (deleteContext, deleteState) {
        return BlocConsumer<SignOutCubit, SignOutState>(
          listener: (signOutContext, signOutState) {
            if (signOutState is SignOutSuccess) {
              customToast(message: 'Successfully sign out');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
              googleLogin = false;
            } else if (signOutState is SignOutFailure) {
              customAwesomeDialog(
                  context: context,
                  titleText: 'Error',
                  contentText: signOutState.errorMessage);
            }
          },
          builder: (signOutContext, signOutState) {
            return deleteState is DeleteCategoryLoading ||
                    state is GetCategoryLoading ||
                    signOutState is SignOutLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Expanded(
                          child: CustomGridViewContent(),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              sendMessageAndReceiveNotification(context);
                            },
                            child: const Text('send notification'))
                      ],
                    ));
          },
        );
      },
    );
  }
}

class CustomGridViewContent extends StatelessWidget {
  const CustomGridViewContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: BlocProvider.of<GetCategoryCubit>(context).categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          mainAxisExtent: 160),
      itemBuilder: (BuildContext context, int index) {
        if (index <
            BlocProvider.of<GetCategoryCubit>(context).categories.length) {
          return GridViewFolderItem(
            title: BlocProvider.of<GetCategoryCubit>(context).categories[index]
                ['name'],
            onTap: () {
              BlocProvider.of<GetNoteCubit>(context).mainPath =
                  BlocProvider.of<GetCategoryCubit>(context)
                      .categories[index]
                      .id;
              BlocProvider.of<AddNoteCubit>(context).mainPath =
                  BlocProvider.of<GetCategoryCubit>(context)
                      .categories[index]
                      .id;
              BlocProvider.of<UpdateNoteCubit>(context).mainPath =
                  BlocProvider.of<GetCategoryCubit>(context)
                      .categories[index]
                      .id;
              Navigator.of(context).pushNamed('note');
            },
            onLongPress: () {
              customAwesomeDialog(
                  context: context,
                  titleText: 'question',
                  contentText: 'Are you want to delete or update it?',
                  dialogType: DialogType.question,
                  color: Colors.amber,
                  cancelText: 'Delete',
                  okText: 'Update',
                  btnOkOnPress: () {
                    BlocProvider.of<UpdateCategoryCubit>(context).path =
                        BlocProvider.of<GetCategoryCubit>(context)
                            .categories[index]
                            .id;
                    BlocProvider.of<UpdateCategoryCubit>(context).oldName =
                        BlocProvider.of<GetCategoryCubit>(context)
                            .categories[index]['name'];
                    Navigator.of(context)
                        .pushReplacementNamed("updateCategory");
                  },
                  btnCancelOnPress: () {
                    BlocProvider.of<DeleteCategoryCubit>(context)
                        .deleteCategory(
                            BlocProvider.of<GetCategoryCubit>(context)
                                .categories[index]
                                .id);
                    BlocProvider.of<GetCategoryCubit>(context).getCategory();
                  });
            },
          );
        } else {
          return null; // or return a fallback widget if needed
        }
      },
    );
  }
}
