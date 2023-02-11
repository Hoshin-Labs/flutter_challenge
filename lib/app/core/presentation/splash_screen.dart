import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:todo_app/app/features/todo/presentation/screens/todo_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationCubit>().checkUserAuth();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, TodoScreen.route);
          });
        } else {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, SignInScreen.route);
          });
        }
      },
      child: const ColoredBox(
        color: Colors.white,
        child: SizedBox.expand(
          child: Center(
            child: Icon(
              Icons.check_circle_outline,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
