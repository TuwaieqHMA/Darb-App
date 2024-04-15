part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignedUpState extends AuthState {
  final String msg;

  SignedUpState({required this.msg});
}

final class LoggedInState extends AuthState {
  final String msg;
  
  LoggedInState({required this.msg});
}

final class SignedOutState extends AuthState {
  final String msg;

  SignedOutState({required this.msg});
}