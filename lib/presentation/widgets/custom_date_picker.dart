import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:employee_app/application/core/constants/app_images.dart';
import 'package:employee_app/application/core/constants/ui_constants.dart';
import 'package:employee_app/application/core/utils/conversion_utils.dart';
import 'package:employee_app/presentation/widgets/date_btn.dart';
import 'package:employee_app/presentation/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'footer_btn.dart';

class CustomDateWidget extends StatefulWidget {
  final bool isEndPicker;
  final Function(String formatedValue, DateTime dateTime) onSelected;
  final DateTime? startDate;
  final DateTime? selectedDate;

  const CustomDateWidget(
      {super.key,
      required this.isEndPicker,
      required this.onSelected,
      this.startDate,
      this.selectedDate});

  @override
  State<CustomDateWidget> createState() => _CustomDateWidgetState();
}

class _CustomDateWidgetState extends State<CustomDateWidget> {
  int selectedIndex = 0;
  DateRangePickerController controller = DateRangePickerController();

  @override
  void initState() {
    if (widget.isEndPicker) {
      selectedIndex = 0;
    } else {
      selectedIndex = 1;
    }
    if (widget.selectedDate != null) {
      controller.displayDate = widget.selectedDate;
      controller.selectedDate = widget.selectedDate;
    }
    controller.addPropertyChangedListener((p0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          print("object");
        });
      });
    });
    super.initState();
  }

  onDateSelected() {
    if (controller.selectedDate != null) {
      widget.onSelected.call(
          ConversionUtils.formatDate(controller.selectedDate!), controller.selectedDate!);
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.removePropertyChangedListener((p0) {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(15),
          headerButtons(),
          verticalSpace(5),

          // Month selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    controller.backward?.call();
                  });
                },
                icon: SvgPicture.asset(
                  AppImages.icPrev,
                  height: 20,
                ),
              ),
              Text(
                DateFormat('MMMM yyyy').format(controller.displayDate ?? DateTime.now()),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    controller.forward?.call();
                  });
                },
                icon: SvgPicture.asset(
                  AppImages.icNext,
                  height: 20,
                ),
              ),
            ],
          ),
          verticalSpace(3),

          // Calendar Picker
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SfDateRangePicker(
              initialDisplayDate: widget.startDate ?? DateTime.now(),
              initialSelectedDate: widget.isEndPicker ? null : DateTime.now(),
              minDate: widget.startDate,
              controller: controller,
              headerHeight: 0,
              monthViewSettings: const DateRangePickerMonthViewSettings(dayFormat: "EEE"),
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                setState(() {
                  selectedIndex = -1;
                });
              },
            ),
          ),
          verticalSpace(5),
          const Divider(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: kPageHPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  AppImages.icDate,
                  height: 25,
                ),
                horizontalSpace(6),
                Text(
                  controller.selectedDate == null
                      ? "No Date"
                      : ConversionUtils.formatDate(controller.selectedDate ?? DateTime.now()),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
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
                    onDateSelected();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerButtons() {
    return Wrap(
      spacing: 10,
      // runSpacing: 10,
      children: [
        if (widget.isEndPicker)
          DateBtn(
            isSelected: selectedIndex == 0,
            title: "No date",
            onPressed: () {
              setState(() {
                selectedIndex = 0;
                controller.selectedDate = null;
              });
            },
          ),
        DateBtn(
          isSelected: selectedIndex == 1,
          title: "Today",
          onPressed: () {
            setState(() {
              selectedIndex = 1;

              controller.displayDate = DateTime.now();
              controller.selectedDate = DateTime.now();
            });
          },
        ),
        if (!widget.isEndPicker)
          DateBtn(
            isSelected: selectedIndex == 2,
            title: "Next Monday",
            onPressed: () {
              setState(() {
                selectedIndex = 2;

                var newDate = DateTime.now().next(DateTime.monday);
                controller.displayDate = newDate;
                controller.selectedDate = newDate;
              });
            },
          ),
        if (!widget.isEndPicker)
          DateBtn(
            isSelected: selectedIndex == 3,
            title: "Next Tuesday",
            onPressed: () {
              setState(() {
                selectedIndex = 3;

                var newDate = DateTime.now().next(DateTime.tuesday);
                controller.displayDate = newDate;
                controller.selectedDate = newDate;
              });
            },
          ),
        if (!widget.isEndPicker)
          DateBtn(
            isSelected: selectedIndex == 4,
            title: "After 1 week",
            onPressed: () {
              setState(() {
                selectedIndex = 4;

                var newDate = DateTime.now().add(const Duration(days: 7));
                controller.displayDate = newDate;
                controller.selectedDate = newDate;
              });
            },
          )
      ],
    );
  }
}
