import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaconsumptiontracker/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository);

  // "liveData" with weather loading
  BehaviorSubject<FirebaseUser> _userLoggedSubject = BehaviorSubject();
  Stream<FirebaseUser> get userLoggedObservable => _userLoggedSubject.stream;

  Future userLoggedIn() async {
    final loggedUser = await _authRepository.userLoggedIn();
    _userLoggedSubject.add(loggedUser);
  }

  @override
  void dispose() {
    super.dispose();
    _userLoggedSubject.close();
  }
}