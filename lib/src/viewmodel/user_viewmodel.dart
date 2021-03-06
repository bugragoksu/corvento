import 'package:eventapp/src/model/user.dart';
import 'package:eventapp/src/services/repository/user_repository.dart';
import 'package:eventapp/src/util/firebase_notification_manager.dart';
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

  Future<String> getToken() async {
    FirebaseNotificationManager _notif = FirebaseNotificationManager();
    String token = await _notif.getToken();
    return token;
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      state = UserState.Busy;
      String firebaseToken = await getToken();
      _user = await _userRepository.createUserWithEmailAndPassword(
          email, password, firebaseToken);
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

  Future<bool> sendFirebaseTokenToServer(String token) async {
    try {
      state = UserState.Busy;
      await _userRepository.sendFirebaseTokenToServer(user.uid, token);
      state = UserState.Idle;
      return true;
    } catch (e) {
      state = UserState.Idle;
      return false;
    }
  }

  Future<bool> sendFeedback(String subject, String message) async {
    try {
      state = UserState.Busy;
      await _userRepository.sendFeedback(user.email, subject, message);
      state = UserState.Idle;
      return true;
    } catch (e) {
      state = UserState.Idle;
      return false;
    }
  }
}
