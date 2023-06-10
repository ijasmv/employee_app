import 'package:employee_app/application/employee/employee_bloc.dart';
import 'package:employee_app/domain/di/injectable.dart';
import 'package:employee_app/domain/employee/model/employee_data.dart';
import 'package:employee_app/infrastructure/core/db_helper.dart';
import 'package:employee_app/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await DbHelper().initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => getIt<EmployeeBloc>(),
      child: MaterialApp(
        title: 'Employee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
