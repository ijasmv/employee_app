import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_app/domain/employee/i_employee_repo.dart';
import 'package:employee_app/domain/statuses/employee_status.dart';
import 'package:employee_app/domain/statuses/status_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/employee/model/employee_data.dart';
part 'employee_event.dart';
part 'employee_state.dart';
part 'employee_bloc.freezed.dart';

@injectable
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final IEmployeeRepo _iEmployeeRepo;
  EmployeeBloc(this._iEmployeeRepo) : super(EmployeeState.initial()) {
    // Add Employee
    on<AddEmployee>((event, emit) async {
      emit(state.copyWith(status: const EmployeeStatus()));
      StatusMessage response = await _iEmployeeRepo.add(event.data);

      if (response.status) {
        add(const GetEmployees());
        emit(state.copyWith(status: const EmployeeStatus.added()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(), errorMessage: response.message));
      }
    });

    // Edit Employee
    on<EditEmployee>((event, emit) async {
      emit(state.copyWith(status: const EmployeeStatus()));
      StatusMessage response = await _iEmployeeRepo.edit(event.data);

      if (response.status) {
        add(const GetEmployees());
        emit(state.copyWith(status: const EmployeeStatus.edited()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(), errorMessage: response.message));
      }
    });

    // Delete Employee
    on<DeleteEmployee>((event, emit) async {
      emit(state.copyWith(lastDeleteData: event.data, status: const EmployeeStatus()));
      StatusMessage response = await _iEmployeeRepo.delete(event.data.id!);

      if (response.status) {
        add(const GetEmployees());
        emit(state.copyWith(status: const EmployeeStatus.deleted()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(), errorMessage: response.message));
      }
    });

    // Undo Employee Delete
    on<UndoDelete>((event, emit) async {
      emit(state.copyWith(status: const EmployeeStatus()));
      StatusMessage response = await _iEmployeeRepo.add(state.lastDeleteData!);

      if (response.status) {
        add(const GetEmployees());
        emit(state.copyWith(status: const EmployeeStatus.undoDelete()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(), errorMessage: response.message));
      }
    });

    // Get All Employees
    on<GetEmployees>((event, emit) async {
      final response = await _iEmployeeRepo.getAll();
      if (response.isNotEmpty) {
        List<EmployeeData> cEmp = [];
        List<EmployeeData> pEmp = [];
        for (var emp in response) {
          if (emp.toDate.isNotEmpty) {
            pEmp.add(emp);
          } else {
            cEmp.add(emp);
          }
        }
        var newState = state.copyWith(
          currentEmployees: cEmp,
          previousEmployees: pEmp,
          status: const EmployeeStatus.fetched(),
        );
        emit(newState);
      }
    });
  }
}
