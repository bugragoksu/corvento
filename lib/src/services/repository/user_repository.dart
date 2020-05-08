import 'package:eventapp/src/model/user.dart';
import 'package:eventapp/src/services/api/firebase_auth.dart';
import 'package:eventapp/src/services/api/server_api.dart';

class UserRepository {
  FirebaseAuthService _api = FirebaseAuthService();
  ServerAPI _server = ServerAPI();
  Future<User> currentUser() async {
    return await _api.currentUser();
  }

  Future<bool> signOut() async {
    return await _api.signOut();
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password,String firebaseToken) async {
    return await _api.createUserWithEmailAndPassword(email, password,firebaseToken);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return await _api.signInWithEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) async {
    return await _api.resetPassword(email);
  }

  Future<void> sendFirebaseTokenToServer(String uid, String email) async {
    return await _server.sendFirebaseTokenToServer(uid, email);
  }

  Future<bool> sendFeedback(
      String email, String subject, String message) async {
    return await _server.sendFeedback(email, subject, message);
  }
}
