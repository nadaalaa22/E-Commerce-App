import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import '../../../../../core/app_theme.dart';
import '../../../data/datasorce/authentication_remote_ds/authentication.dart';
import '../../../data/datasorce/user_remote_ds/user_remote_ds.dart';
import '../../../data/model/user_model.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRemoteDS authenticationRemoteDS;
  final UsersDBModel usersDBModel;

  AuthenticationBloc(this.authenticationRemoteDS, this.usersDBModel)
      : super(UnAuthorized()) {
    on<AuthenticationEvent>((event, emit) async {
      try {
        if (event is SignInEvent) {
          emit(LoadingState());
          await authenticationRemoteDS.signIn(event.email, event.password);
          emit(Authorized()) ;
        } else if (event is SignUpEvent) {
          emit(LoadingState());
          await authenticationRemoteDS.signUp(event.email, event.password);
          await usersDBModel.addUser(event.userModel);
          emit(UnAuthorized());
        } else if (event is SignOutEvent) {
          emit(LoadingState());
          await authenticationRemoteDS.signOut();
          emit(UnAuthorized());
        } else if (event is CheckIfAuthEvent) {
          emit(LoadingState());
          bool isAuth = authenticationRemoteDS.checkIfAuth();
          print('Is Authenticated: $isAuth');
          emit(isAuth ? Authorized() : UnAuthorized());
        }
        else if(event is ResetPasswordEvent){
          emit(LoadingState());
          await authenticationRemoteDS.resetPassword(event.email);
          emit(UnAuthorized());
          Fluttertoast.showToast(
            msg: "Password reset email sent!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.deepPurple,
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Invalid Data, Please try again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0,
        );
        emit(AuthError(error: error.toString()));
      }
    });
  }
}