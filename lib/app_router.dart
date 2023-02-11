import 'package:flutter/material.dart';
import 'package:todo_app/app/core/presentation/splash_screen.dart';
import 'package:todo_app/app/features/auth/presentation/screens/register_screen.dart';
import 'package:todo_app/app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:todo_app/app/features/todo/presentation/screens/task_information_screen.dart';
import 'package:todo_app/app/features/todo/presentation/screens/todo_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashScreen(),
        );
      case SignInScreen.route:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignInScreen(),
        );
      case RegisterScreen.route:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RegisterScreen(),
        );
      case TodoScreen.route:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const TodoScreen(),
        );
      case TaskInformationScreen.route:
        final args = settings.arguments as TaskInformationScreenArgs?;
        return MaterialPageRoute<dynamic>(
          builder: (_) => TaskInformationScreen(
            task: args?.task,
          ),
        );
    }
    return null;
  }
}
