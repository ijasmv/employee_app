import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../application/core/constants/ui_constants.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kPageHPadding,
        vertical: kPageVPadding,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
