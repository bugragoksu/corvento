import 'package:eventapp/src/services/api/firebase_sign.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseSign _sign = FirebaseSign();

  Future signIn(String email, String password) async {
    return _sign.signIn(email, password);
  }

  Future<String> signUp(String email, String password) async {
    return _sign.signUp(email, password);
  }

  Future<FirebaseUser> getCurrentUser() async {
    return _sign.getCurrentUser();
  }

  Future<void> signOut() async {
    return _sign.signOut();
  }
}
