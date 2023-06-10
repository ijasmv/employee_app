// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeData _$EmployeeDataFromJson(Map<String, dynamic> json) => EmployeeData(
      id: json['id'] as int?,
      fromDate: json['fromDate'] as String? ?? "",
      name: json['name'] as String? ?? "",
      role: json['role'] as String? ?? "",
      toDate: json['toDate'] as String? ?? "",
    );

Map<String, dynamic> _$EmployeeDataToJson(EmployeeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
