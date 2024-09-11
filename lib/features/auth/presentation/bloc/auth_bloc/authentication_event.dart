part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String email, password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthenticationEvent {
  final String email, password;
  final UserModel userModel;

  SignUpEvent(this.userModel, {required this.email, required this.password});
}

class SignOutEvent extends AuthenticationEvent {}

class CheckIfAuthEvent extends AuthenticationEvent {}

class SendUserVerification extends AuthenticationEvent {}

class ResetPasswordEvent extends AuthenticationEvent {
  final String email;

  ResetPasswordEvent(this.email);
}