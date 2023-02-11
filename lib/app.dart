// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/app/core/presentation/splash_screen.dart';
import 'package:todo_app/app/features/auth/data/data_source/auth_repository_impl.dart';
import 'package:todo_app/app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/app/features/todo/data/data_source/todo_repository_impl.dart';
import 'package:todo_app/app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_app/app_router.dart';
import 'package:todo_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepositoryImpl>(
          create: (context) => AuthRepositoryImpl(),
        ),
        RepositoryProvider<TodoRepositoryImpl>(
          create: (context) => TodoRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            create: (context) => AuthenticationCubit(
              RepositoryProvider.of<AuthRepositoryImpl>(context),
            ),
          ),
           BlocProvider<TodoCubit>(
            create: (context) => TodoCubit(
              RepositoryProvider.of<TodoRepositoryImpl>(context),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF13B9FF),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: SplashScreen.route,
        ),
      ),
    );
  }
}
