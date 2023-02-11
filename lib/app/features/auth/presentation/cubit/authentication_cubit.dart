import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/app/features/auth/data/data_source/auth_repository_impl.dart';
import 'package:todo_app/app/features/auth/domain/entities/user_entity.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.authRepository) : super(AuthenticationInitial());

  final AuthRepositoryImpl authRepository;

  Future<void> checkUserAuth() async {
    try {
      final user = await authRepository.retrieveCurrentUser();
      if (user != null) {
        emit(AuthenticationSuccess(user));
      } else {
        emit(AuthenticationFailure());
      }
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await authRepository.login(email, password);
      if (userCredential != null) {
        final user = await authRepository.retrieveCurrentUser();
        if (user != null) {
          emit(AuthenticationSuccess(user));
        } else {
          emit(AuthenticationFailure());
        }
      } else {
        emit(AuthenticationFailure());
      }
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      final userCredential = await authRepository.register(email, password);
      if (userCredential != null) {
        final user = await authRepository.retrieveCurrentUser();
        if (user != null) {
          emit(AuthenticationSuccess(user));
        } else {
          emit(AuthenticationFailure());
        }
      } else {
        emit(AuthenticationFailure());
      }
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  //send notification
  Future<void> sendNotification(String message) async {
    try {
      await authRepository.sendNotification(message);
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }
}
