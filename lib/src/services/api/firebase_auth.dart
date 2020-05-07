import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/src/model/user.dart';
import 'package:eventapp/src/services/api/server_api.dart';
import 'package:eventapp/src/util/toast_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final ToastManager _toast = ToastManager();
  ServerAPI _api = ServerAPI();
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      return User.fromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userRegisterToDatabase(result.user);
      _api.userRegisterToDatabase(result.user);
      _toast.localizedMessageFromFirebase("Create User Successful");
      return User.fromFirebaseUser(result.user);
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);

      return null;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return User.fromFirebaseUser(result.user);
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _toast.localizedMessageFromFirebase("Success Reset Password");
    } catch (error) {
      _toast.localizedMessageFromFirebase(error.code);
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
      _toast.localizedMessageFromFirebase(e.code);
      return false;
    }
  }
}
