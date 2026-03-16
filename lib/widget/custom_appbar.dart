import 'package:flutter/material.dart';
import '../../utils/app_colors/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final Color backgroundColor;
  final Color titleColor;
  final double? height;
  final Color backIconColor;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.backgroundColor = AppColors.whiteColor,
    this.titleColor = AppColors.blackColor,
    this.backIconColor = AppColors.blackColor,
    this.actions,
    this.height = 56,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,

      // BACK BUTTON
      leading: showBack
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: backIconColor,
        ),
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
      )
          : null,

      // TITLE
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: titleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      actions: actions,
    );
  }
}
