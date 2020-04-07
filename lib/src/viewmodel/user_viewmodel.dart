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

  signIn(String email, String password) async {
    String uid;
    try {
      _state = UserState.UserLoadingState;
      uid = _repository.signIn(email, password);
      if (uid != null) {
        _state = UserState.UserNotLoggedInState;
      }
    } catch (e) {
      _state = UserState.UserErrorState;
    }
    return uid;
  }

  Future<String> signUp(String email, String password) async {
    String uid;
    try {
      _state = UserState.UserLoadingState;
      uid = await _repository.signUp(email, password);
      if (uid != null) {
        _state = UserState.UserLoggedInState;
        uid = "";
      }
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

  Future<void> signOut() async {
    try {
      _state = UserState.UserLoadingState;
      await _repository.signOut();
      if (user != null) {
        _state = UserState.UserNotLoggedInState;
      }
    } catch (e) {
      _state = UserState.UserErrorState;
    }
  }
}
