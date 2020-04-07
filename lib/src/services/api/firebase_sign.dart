import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSign {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
