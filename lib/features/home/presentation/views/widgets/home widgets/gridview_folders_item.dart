import 'package:firebase_training/core/constants.dart';
import 'package:flutter/material.dart';

class GridViewFolderItem extends StatelessWidget {
  const GridViewFolderItem(
      {super.key, required this.title, this.onLongPress, this.onTap});
  final String title;
  final void Function()? onLongPress;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Image.asset(
              folderLogo,
              height: 100,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
