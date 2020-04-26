import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({FirebaseAuth auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<FirebaseUser> userLoggedIn() async {
    return (await _auth.currentUser());
  }

  Future<FirebaseUser> loginWithCredentials({String email, String password}) async {
      return ( await _auth.signInWithEmailAndPassword(
          email: email, password: password
      )).user;
  }

  Future<FirebaseUser> registerUser({String email, String password}) async {
    return ( await _auth.createUserWithEmailAndPassword(
        email: email, password: password
    )).user;
  }

  Future<void> logoutUser() async {
    return await (
      _auth.signOut()
    );
  }
}