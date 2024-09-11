part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class LoadingState extends AuthenticationState {}

class Authorized extends AuthenticationState {}

class UnAuthorized extends AuthenticationState {}

class AuthError extends AuthenticationState {
  final String error;

  AuthError({required this.error});
}