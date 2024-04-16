part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String rePassword;
  final String userType;
  SignUpEvent({required this.name,required this.email,required this.phone,required this.password,required this.rePassword, required this.userType});
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class SignOutEvent extends AuthEvent {
  
}

final class RedirectEvent extends AuthEvent {
}