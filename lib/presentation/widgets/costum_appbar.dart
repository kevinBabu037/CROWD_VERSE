
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  final void Function()? onPressed;
  const CustomAppBar({
    super.key, 
    required this.title,
    this.icon,
    this.onPressed
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onPressed, 
        icon: Icon(icon,color:kClrBlack,)
        ),
      centerTitle: true,
      title: Text(
        title,
        style: kAppBarHedingStyke,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}