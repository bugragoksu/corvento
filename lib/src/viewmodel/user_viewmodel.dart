import 'package:eventapp/src/model/user.dart';
import 'package:eventapp/src/services/repository/user_repository.dart';
import 'package:flutter/material.dart';

enum UserState { Idle, Busy }

class UserViewModel with ChangeNotifier {
  UserState _state = UserState.Idle;
  UserRepository _userRepository = UserRepository();
  User _user;

  User get user => _user;

  UserState get state => _state;

  set state(UserState value) {
    _state = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
  }

  Future<User> currentUser() async {
    try {
      state = UserState.Busy;
      _user = await _userRepository.currentUser();
      state = UserState.Idle;
      return _user;
    } catch (e) {
      state = UserState.Idle;
      return null;
    }
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      state = UserState.Busy;
      _user =
          await _userRepository.createUserWithEmailAndPassword(email, password);
      state = UserState.Idle;
      return _user;
    } catch (e) {
      state = UserState.Idle;
      return null;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      state = UserState.Busy;
      _user = await _userRepository.signInWithEmailAndPassword(email, password);
      state = UserState.Idle;
      return _user;
    } catch (e) {
      state = UserState.Idle;
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      state = UserState.Busy;
      bool result = await _userRepository.signOut();
      _user = null;
      state = UserState.Idle;
      return result;
    } catch (e) {
      state = UserState.Idle;
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      state = UserState.Busy;
      await _userRepository.resetPassword(email);
      state = UserState.Idle;
    } catch (e) {
      state = UserState.Idle;
      return false;
    }
  }
}
