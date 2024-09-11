part of 'user_data_bloc.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}
class UserLoadingState extends UserDataState {}
class UserLoadedState extends UserDataState {
 final  List<UserModel> usersModel ;

 UserLoadedState({required this.usersModel});
}
