import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FooterBtn extends StatelessWidget {
  const FooterBtn(
      {super.key, required this.title, this.color, this.fontColor, required this.onPressed});
  final String title;
  final Color? color;
  final Color? fontColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Text(
        title,
        style: TextStyle(
          color: fontColor ?? AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
