part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState() : super();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess(this.user);
  final UserEntity user;

  @override
  List<Object> get props => [user];
}
