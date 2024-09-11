import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDS {
  ///
  Future<void> signUp(String email, String password);

  ///
  Future<void> signIn(String email, String password);

  ///
  Future<void> signOut();

  ///
  bool checkIfAuth();

  /// New method to reset password
  Future<void> resetPassword(String email);
}

class AuthenticationImp implements AuthenticationRemoteDS {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  bool checkIfAuth() => _firebaseAuth.currentUser != null;

  @override
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("sign up done ");
  }



  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}