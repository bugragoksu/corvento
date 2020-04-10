import 'package:eventapp/src/model/user.dart';
import 'package:eventapp/src/services/api/firebase_auth.dart';

class UserRepository {
  FirebaseAuthService _api = FirebaseAuthService();
  Future<User> currentUser() async {
    return await _api.currentUser();
  }

  Future<bool> signOut() async {
    return await _api.signOut();
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _api.createUserWithEmailAndPassword(email, password);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return await _api.signInWithEmailAndPassword(email, password);
  }
}
