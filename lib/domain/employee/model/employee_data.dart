import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_data.g.dart';

@JsonSerializable()
class EmployeeData {
  int? id;
  String name;
  String role;
  String fromDate;
  String toDate;

  EmployeeData({
    this.id,
    this.fromDate = "",
    this.name = "",
    this.role = "",
    this.toDate = "",
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => _$EmployeeDataFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDataToJson(this);
}
