part of 'employee_bloc.dart';

@freezed
class EmployeeEvent with _$EmployeeEvent {
  const factory EmployeeEvent.addEmployee({required EmployeeData data}) = AddEmployee;
  const factory EmployeeEvent.editEmployee({required EmployeeData data}) = EditEmployee;
  const factory EmployeeEvent.getEmployees() = GetEmployees;
  const factory EmployeeEvent.deleteEmployee({required EmployeeData data}) = DeleteEmployee;
  const factory EmployeeEvent.undoDelete() = UndoDelete;
}
