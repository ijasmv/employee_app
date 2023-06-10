import 'package:flutter/material.dart';
import '../../application/core/constants/app_colors.dart';

class DateBtn extends StatelessWidget {
  const DateBtn(
      {super.key, required this.isSelected, required this.title, required this.onPressed});
  final bool isSelected;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor:
                isSelected ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.primaryColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
