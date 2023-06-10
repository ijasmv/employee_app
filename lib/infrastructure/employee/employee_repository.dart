import 'package:employee_app/domain/employee/i_employee_repo.dart';
import 'package:employee_app/domain/employee/model/employee_data.dart';
import 'package:employee_app/infrastructure/core/db_constants.dart';
import 'package:employee_app/infrastructure/core/db_helper.dart';
import 'package:injectable/injectable.dart';

import '../../domain/statuses/status_message.dart';

@LazySingleton(as: IEmployeeRepo)
class EmployeeRepository implements IEmployeeRepo {
  DbHelper dbHelper = DbHelper.internal();

  @override
  Future<StatusMessage> add(EmployeeData data) async {
    StatusMessage response = StatusMessage.initial();
    try {
      int? id = await dbHelper.db?.insert(DbConstants.tblEmployee, data.toJson());
      if (id != null && id > 0) {
        response.status = true;
      }
    } catch (_) {
      response.status = false;
      response.message = "Something went wrong";
    }
    return response;
  }

  @override
  Future<StatusMessage> delete(int employeeId) async {
    StatusMessage response = StatusMessage.initial();

    try {
      int? id = await dbHelper.db
          ?.delete(DbConstants.tblEmployee, where: "id = ?", whereArgs: [employeeId]);
      if (id != null && id > 0) {
        response.status = true;
      }
    } catch (_) {
      response.status = false;
      response.message = "Something went wrong";
    }

    return response;
  }

  @override
  Future<StatusMessage> edit(EmployeeData data) async {
    StatusMessage response = StatusMessage.initial();

    try {
      int? id = await dbHelper.db?.update(DbConstants.tblEmployee, data.toJson(),
          where: "id = ?", whereArgs: [data.id]);
      if (id != null && id > 0) {
        response.status = true;
      }
    } catch (_) {
      response.status = false;
      response.message = "Something went wrong";
    }
    return response;
  }

  @override
  Future<List<EmployeeData>> getAll() async {
    List<EmployeeData> data = [];
    try {
      final vouchers = await dbHelper.db?.rawQuery("SELECT * FROM ${DbConstants.tblEmployee}");
      if (vouchers != null) {
        List<EmployeeData> pros = vouchers.map((data) => EmployeeData.fromJson(data)).toList();
        if (pros.isNotEmpty) {
          data = pros;
        }
      }
    } catch (_) {}
    return data;
  }
}
