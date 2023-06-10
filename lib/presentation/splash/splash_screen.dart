import 'package:employee_app/application/core/constants/app_colors.dart';
import 'package:employee_app/application/employee/employee_bloc.dart';
import 'package:employee_app/presentation/employee/employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<EmployeeBloc>().add(const GetEmployees());
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const EmployeeScreen()));
    });
    return const Scaffold(
        body: Center(
      child: Icon(
        Icons.person,
        color: AppColors.primaryColor,
        size: 100,
      ),
    ));
  }
}
