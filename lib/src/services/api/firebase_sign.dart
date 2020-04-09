import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSign {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

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
      var isRegister = await userRegisterToDatabase(user);
      if (isRegister != null) {
        return user.uid;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future userRegisterToDatabase(FirebaseUser user) async {
    try {
      var data = {
        "uid": user.uid,
        "email": user.email,
        "name": '',
        "profilePic": '',
        'createdDate': DateTime.now()
      };
      await _db.collection('users').document(user.uid).setData(data);

      //await _db.collection('users').add();
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

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
