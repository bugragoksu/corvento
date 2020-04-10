import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/src/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      return User.fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userRegisterToDatabase(result.user);
      return User.fromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> userRegisterToDatabase(FirebaseUser user) async {
    try {
      var data = {
        "uid": user.uid,
        "email": user.email,
        "name": '',
        "profilePic": '',
        'createdDate': DateTime.now()
      };
      await _db.collection('users').document(user.uid).setData(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return User.fromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
