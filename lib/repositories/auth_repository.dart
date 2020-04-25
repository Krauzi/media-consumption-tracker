import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({FirebaseAuth auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<FirebaseUser> userLoggedIn() async {
    return (await _auth.currentUser());
  }
}