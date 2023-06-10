import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:employee_app/application/core/constants/app_images.dart';
import 'package:employee_app/application/core/constants/ui_constants.dart';
import 'package:employee_app/domain/statuses/employee_status.dart';
import 'package:employee_app/presentation/employee/add_employee_screen.dart';
import 'package:employee_app/presentation/employee/widgets/list_widget.dart';
import 'package:employee_app/presentation/employee/widgets/title_widget.dart';
import 'package:employee_app/presentation/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../application/employee/employee_bloc.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state.status == const EmployeeStatus.deleted()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Employee data has been deleted"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                context.read<EmployeeBloc>().add(const UndoDelete());
              },
            ),
          ));
        } else if (state.status == const EmployeeStatus.undoDelete()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Undone last delete"),
          ));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgScaffold,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => AddEmployeeScreen(),
                ));
          },
          elevation: 0,
          mini: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          title: const Text(
            "Employee List",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (ctx, state) {
              if (state.currentEmployees.isEmpty && state.previousEmployees.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.icNoData,
                          height: 200,
                        ),
                        verticalSpace(5),
                        const Text(
                          "No employee records found",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.currentEmployees.isNotEmpty)
                      const TitleWidget(title: "Current employees"),
                    ListWidget(
                      data: state.currentEmployees,
                    ),
                    if (state.previousEmployees.isNotEmpty)
                      const TitleWidget(title: "Previous employees"),
                    ListWidget(
                      data: state.previousEmployees,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kPageHPadding,
                        vertical: 15,
                      ),
                      child: Text(
                        "Swipe left to delete",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    verticalSpace(50),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
