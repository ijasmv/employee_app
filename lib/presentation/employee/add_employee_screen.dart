import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:employee_app/application/core/constants/app_images.dart';
import 'package:employee_app/application/core/constants/ui_constants.dart';
import 'package:employee_app/application/core/utils/conversion_utils.dart';
import 'package:employee_app/application/employee/employee_bloc.dart';
import 'package:employee_app/domain/employee/model/employee_data.dart';
import 'package:employee_app/domain/statuses/employee_status.dart';
import 'package:employee_app/presentation/employee/widgets/role_option_widget.dart';
import 'package:employee_app/presentation/widgets/custom_date_picker.dart';
import 'package:employee_app/presentation/widgets/custom_textfield.dart';
import 'package:employee_app/presentation/widgets/footer_btn.dart';
import 'package:employee_app/presentation/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key, this.editData});
  final EmployeeData? editData;
  final TextEditingController nameCntl = TextEditingController();
  final TextEditingController fromDateCntl = TextEditingController();
  final TextEditingController toDateCntl = TextEditingController();
  final TextEditingController roleCntl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime? fromDateTime;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (editData != null) {
        nameCntl.text = editData!.name;
        roleCntl.text = editData!.role;
        fromDateCntl.text = editData!.fromDate;
        if (fromDateCntl.text.isNotEmpty) {
          fromDateTime = ConversionUtils.getDateTime(fromDateCntl.text);
        }
        toDateCntl.text = editData!.toDate;
      }
    });
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (ctx, state) {
        if (state.status == const EmployeeStatus.added()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Employee Added")));
        } else if (state.status == const EmployeeStatus.edited()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Employee Edited")));
        } else if (state.status == const EmployeeStatus.failed()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state.status == const EmployeeStatus.deleted()) {
          Navigator.pop(context);
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(content: Text("Deleted Employee!")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Add Employee Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: editData != null
              ? [
                  IconButton(
                      onPressed: () {
                        context.read<EmployeeBloc>().add(DeleteEmployee(data: editData!));
                      },
                      icon: SvgPicture.asset(
                        AppImages.icDelete,
                      ))
                ]
              : null,
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: kPageVPadding, horizontal: kPageHPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: "Employee name",
                  controller: nameCntl,
                  icon: SvgPicture.asset(
                    AppImages.icPerson,
                  ),
                  validator: (value) {
                    return value.isNotEmpty;
                  },
                ),
                verticalSpace(10),
                CustomTextField(
                  label: "Select role",
                  controller: roleCntl,
                  readOnly: true,
                  validator: (value) {
                    return value.isNotEmpty;
                  },
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                      builder: (ctx) {
                        return RoleOptionWidget(
                          onSelected: (value) {
                            roleCntl.text = value;
                          },
                        );
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    AppImages.icRole,
                  ),
                  suffixIcon: SvgPicture.asset(
                    AppImages.icDropDown,
                  ),
                ),
                verticalSpace(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "No Date",
                        controller: fromDateCntl,
                        readOnly: true,
                        icon: SvgPicture.asset(
                          AppImages.icDate,
                        ),
                        validator: (value) {
                          return value.isNotEmpty;
                        },
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomDateWidget(
                              isEndPicker: false,
                              selectedDate: fromDateTime,
                              onSelected: (fmtedValue, dateTime) {
                                fromDateCntl.text = fmtedValue;
                                fromDateTime = dateTime;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: SvgPicture.asset(
                        AppImages.icArrow,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        label: "No Date",
                        readOnly: true,
                        controller: toDateCntl,
                        icon: SvgPicture.asset(
                          AppImages.icDate,
                        ),
                        onTap: () {
                          if (fromDateCntl.text.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => CustomDateWidget(
                                isEndPicker: true,
                                startDate: fromDateTime,
                                selectedDate: toDateCntl.text.isEmpty
                                    ? null
                                    : ConversionUtils.getDateTime(toDateCntl.text),
                                onSelected: (fmtedValue, dateTime) {
                                  toDateCntl.text = fmtedValue;
                                },
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please select start date")));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FooterBtn(
                      title: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fontColor: AppColors.primaryColor,
                      color: AppColors.primaryColor.withOpacity(.12),
                    ),
                    horizontalSpace(10),
                    FooterBtn(
                      title: "Save",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (editData != null) {
                            //Edit
                            context.read<EmployeeBloc>().add(EditEmployee(
                                    data: EmployeeData(
                                  id: editData!.id,
                                  name: nameCntl.text,
                                  fromDate: fromDateCntl.text,
                                  role: roleCntl.text,
                                  toDate: toDateCntl.text,
                                )));
                          } else {
                            //Add
                            context.read<EmployeeBloc>().add(AddEmployee(
                                    data: EmployeeData(
                                  name: nameCntl.text,
                                  fromDate: fromDateCntl.text,
                                  role: roleCntl.text,
                                  toDate: toDateCntl.text,
                                )));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
