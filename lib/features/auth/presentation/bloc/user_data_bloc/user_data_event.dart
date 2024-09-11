part of 'user_data_bloc.dart';

@immutable
abstract class UserDataEvent {}

class SetUserEvent extends UserDataEvent {
  final UserModel userModel ;

  SetUserEvent({required this.userModel});

}

class GetUserEvent extends UserDataEvent {
}