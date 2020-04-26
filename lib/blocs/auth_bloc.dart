import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaconsumptiontracker/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository);

  BehaviorSubject<FirebaseUser> _userLoggedSubject = BehaviorSubject();
  Stream<FirebaseUser> get userLoggedObservable => _userLoggedSubject.stream;

  PublishSubject<FirebaseUser> _loginSubject = PublishSubject();
  Stream<FirebaseUser> get loginObservable => _loginSubject.stream;

  PublishSubject<FirebaseUser> _signUpSubject = PublishSubject();
  Stream<FirebaseUser> get signUpObservable => _signUpSubject.stream;

  Future userLoggedIn() async {
    final loggedUser = await _authRepository.userLoggedIn();
    _userLoggedSubject.add(loggedUser);
  }

  Future login({String email, String password}) async {
    _authRepository.loginWithCredentials(
        email: email, password: password)
        .then(_loginSubject.add)
        .catchError((_) => _loginSubject.add(null));
  }

  Future signUp({String email, String password}) async {
    _authRepository.registerUser(email: email, password: password)
        .then(_signUpSubject.add)
        .catchError((_) => _signUpSubject.add(null));
  }

  Future logOut() async {
    _authRepository.logoutUser()
        .then((_) {
          _userLoggedSubject.add(null);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _userLoggedSubject.close();
    _loginSubject.close();
    _signUpSubject.close();
  }
}