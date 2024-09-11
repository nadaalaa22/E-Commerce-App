import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/datasorce/user_remote_ds/user_remote_ds.dart';
import '../../../data/model/user_model.dart';


part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UsersDBModel usersDBModel;
  UserDataBloc(this.usersDBModel) : super(UserDataInitial()) {
    on<UserDataEvent>((event, emit) async {
      if (event is SetUserEvent) {
        emit(UserLoadingState());
        List<UserModel> users = await usersDBModel.getUsers() ;
        emit(UserLoadedState(usersModel: users)) ;
      }
      else if (event is GetUserEvent) {
        emit(UserLoadingState());
        List<UserModel> users = await usersDBModel.getUsers() ;
        print(users);
        emit(UserLoadedState(usersModel: users)) ;

      }
    });
  }
}
