part of 'employee_bloc.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState({
    required List<EmployeeData> currentEmployees,
    required List<EmployeeData> previousEmployees,
    required EmployeeStatus status,
    required String errorMessage,
    required EmployeeData? lastDeleteData,
  }) = _EmployeeState;

  factory EmployeeState.initial() {
    return const EmployeeState(
      status: EmployeeStatus(),
      currentEmployees: [],
      previousEmployees: [],
      errorMessage: "",
      lastDeleteData: null,
    );
  }
}
