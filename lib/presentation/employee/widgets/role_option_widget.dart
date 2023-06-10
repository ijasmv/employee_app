import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RoleOptionWidget extends StatelessWidget {
  RoleOptionWidget({super.key, required this.onSelected});
  final Function(String value) onSelected;
  final List<String> options = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(options.length, (index) {
        return InkWell(
          onTap: () {
            Navigator.pop(context);
            onSelected.call(options[index]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                    bottom: BorderSide(
                  color: AppColors.borderGrey.withOpacity(.3),
                ))),
            child: Center(
              child: Text(options[index]),
            ),
          ),
        );
      }),
    );
  }
}
