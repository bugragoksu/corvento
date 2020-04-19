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
      return _user;
    } catch (e) {
      return null;
    } finally {
      state = UserState.Idle;
    }
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      state = UserState.Busy;
      _user =
          await _userRepository.createUserWithEmailAndPassword(email, password);
      return _user;
    } catch (e) {
      return null;
    } finally {
      state = UserState.Idle;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      state = UserState.Busy;
      _user = await _userRepository.signInWithEmailAndPassword(email, password);
      return _user;
    } catch (e) {
      return null;
    } finally {
      state = UserState.Idle;
    }
  }

  Future<bool> signOut() async {
    try {
      state = UserState.Busy;
      bool result = await _userRepository.signOut();
      _user = null;
      return result;
    } catch (e) {
      return false;
    } finally {
      state = UserState.Idle;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      state = UserState.Busy;
      await _userRepository.resetPassword(email);
    } catch (e) {
      return false;
    } finally {
      state = UserState.Idle;
    }
  }
}
