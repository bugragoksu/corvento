import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/src/services/repository/firebase_user_repository.dart';

enum UserState {
  InitialUserState,
  UserLoadingState,
  UserLoggedInState,
  UserNotLoggedInState,
  UserErrorState
}

class UserViewModel with ChangeNotifier {
  UserState _state;
  UserRepository _repository;
  FirebaseUser user;

  UserViewModel() {
    _state = UserState.InitialUserState;
    _repository = UserRepository();
    initUser();
  }

  initUser() async {
    user = await getCurrentUser();
  }

  UserState get state => _state;

  set state(UserState value) {
    _state = value;
    notifyListeners();
  }

  Future signIn(String email, String password) async {
    var result;
    try {
      _state = UserState.UserLoadingState;
      result = await _repository.signIn(email, password);
      _state = UserState.UserNotLoggedInState;
    } catch (e) {
      _state = UserState.UserErrorState;
    }
    return result;
  }

  Future<String> signUp(String email, String password) async {
    String uid;
    try {
      _state = UserState.UserLoadingState;
      uid = await _repository.signUp(email, password);
      _state = UserState.UserLoggedInState;
    } catch (e) {
      _state = UserState.UserErrorState;
    }
    return uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      _state = UserState.UserLoadingState;
      user = await _repository.getCurrentUser();
      if (user != null) {
        _state = UserState.UserLoggedInState;
      } else {
        _state = UserState.UserNotLoggedInState;
      }
    } catch (e) {
      _state = UserState.UserErrorState;
    }
    return user;
  }

  Future signOut() async {
    try {
      _state = UserState.UserLoadingState;
      await _repository.signOut();
      _state = UserState.UserNotLoggedInState;
    } catch (e) {
      _state = UserState.UserErrorState;
    }
  }
}
