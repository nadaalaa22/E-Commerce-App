import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../data/datasorce/authentication_remote_ds/authentication.dart';
import '../../../data/datasorce/user_remote_ds/user_remote_ds.dart';
import '../../../data/model/auth_model.dart';
import '../../../data/model/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRemoteDs authenticationRemoteDs;
  final UsersRemoteDs usersDBModel;

  AuthBloc({required this.usersDBModel, required this.authenticationRemoteDs})
      : super(UserUnauthorized()) {
    on<AuthEvent>((event, emit) async {
      print(event); // Debugging: Print the event
      try {
        if (event is SignUp) {
          emit(UserAuthLoadingState());
          await authenticationRemoteDs.signUp(event.authModel);

          // Ensure the user ID is fetched correctly
          final String userId = authenticationRemoteDs.getUserId();
          print('User signed up with ID: $userId');

          // Create a new UserModel with the correct user ID
          UserModel updatedUserModel = event.userModel.copyWith(userId: userId);

          // Add user to Firestore with the correct user ID
          await usersDBModel.addUser(updatedUserModel);

          print('User added to Firestore successfully');
          emit(UserAuthorizedState());
        }
        else if (event is SignIn) {
          emit(UserAuthLoadingState());
          await authenticationRemoteDs.signIn(event.userModel);

          if (authenticationRemoteDs.checkIfAuth()) {
            emit(UserAuthorizedState());
          } else {
            emit(UserUnauthorized());
          }
        } else if (event is CheckIfAuth) {
          emit(UserAuthLoadingState());
          final bool isSignedIn = authenticationRemoteDs.checkIfAuth();
          final bool isAnonymous = authenticationRemoteDs.checkUserSignInStatus();

          if (isSignedIn && isAnonymous) {
            emit(UserAnonymousState());
          } else if (isSignedIn) {
            emit(UserAuthorizedState());
          } else {
            emit(UserUnauthorized());
          }
        } else if (event is SignOut) {
          emit(UserAuthLoadingState());
          await authenticationRemoteDs.signOut();
          emit(UserUnauthorized());
        }
      }catch (e) {
        print('Error in AuthBloc: $e'); // Debugging: Print the error
        if (e is TypeError) {
          print('Type Error details: ${e.toString()}'); // Additional debugging for type errors
        }
        emit(UserErrorState(
            error: 'Please enter your credentials correctly or sign up.'));
      }


    });
  }
}
