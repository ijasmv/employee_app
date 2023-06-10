// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:employee_app/application/employee/employee_bloc.dart' as _i5;
import 'package:employee_app/domain/employee/i_employee_repo.dart' as _i3;
import 'package:employee_app/infrastructure/employee/employee_repository.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IEmployeeRepo>(() => _i4.EmployeeRepository());
  gh.factory<_i5.EmployeeBloc>(() => _i5.EmployeeBloc(gh<_i3.IEmployeeRepo>()));
  return getIt;
}
