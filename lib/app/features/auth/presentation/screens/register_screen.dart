import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/app/features/todo/presentation/screens/todo_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String route = '/register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            Navigator.pushReplacementNamed(
              context,
              TodoScreen.route,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Register TODO App',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 80),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 21,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<AuthenticationCubit>().register(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                },
                                child: state is! AuthenticationLoading
                                    ? const Text('Register')
                                    : const CircularProgressIndicator.adaptive(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: _validateInput,
                              child: const Text(
                                'Already have an account? Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validateInput() {
    //check email and password
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        TodoScreen.route,
      );
    }
  }
}
