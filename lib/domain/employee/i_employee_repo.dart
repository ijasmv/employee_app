import 'package:employee_app/domain/employee/model/employee_data.dart';
import 'package:employee_app/domain/statuses/status_message.dart';

abstract class IEmployeeRepo {
  Future<StatusMessage> add(EmployeeData data);
  Future<StatusMessage> edit(EmployeeData data);
  Future<StatusMessage> delete(int id);
  Future<List<EmployeeData>> getAll();
}
