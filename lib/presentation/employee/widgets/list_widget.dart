import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:employee_app/application/core/constants/app_images.dart';
import 'package:employee_app/application/core/constants/ui_constants.dart';
import 'package:employee_app/application/employee/employee_bloc.dart';
import 'package:employee_app/domain/employee/model/employee_data.dart';
import 'package:employee_app/presentation/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import '../add_employee_screen.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.data});
  final List<EmployeeData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index) {
        return SwipeActionCell(
          isDraggable: true,
          backgroundColor: AppColors.transparent,
          key: ObjectKey(data[index].id),
          trailingActions: <SwipeAction>[
            SwipeAction(
                icon: SvgPicture.asset(
                  AppImages.icDelete,
                  height: 25,
                ),
                onTap: (CompletionHandler handler) async {
                  context.read<EmployeeBloc>().add(DeleteEmployee(data: data[index]));
                },
                color: AppColors.red),
          ],
          child: InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AddEmployeeScreen(
                      editData: data[index],
                    ),
                  ));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: kPageHPadding,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: AppColors.borderGrey.withOpacity(.3),
                  ))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index].name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(6),
                  Text(
                    data[index].role,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  verticalSpace(6),
                  Text(
                    data[index].toDate.isEmpty
                        ? data[index].fromDate
                        : "${data[index].fromDate} - ${data[index].toDate}",
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
