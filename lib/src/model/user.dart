import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String profilePic;
  final DateTime createdDate;
  User({
    this.uid,
    this.name,
    this.email,
    this.profilePic,
    this.createdDate,
  });

  factory User.fromFirebaseUser(FirebaseUser user) {
    return User(
        name: user.displayName ?? '',
        uid: user.uid ?? '',
        createdDate: DateTime.now(),
        email: user.email ?? '',
        profilePic: '');
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return User(
      uid: doc.documentID ?? '',
      name: data["name"] ?? '',
      email: data["email"] ?? '',
      profilePic: data['profilePic'] ?? '',
      createdDate: data['createdDate'].toDate() ?? DateTime.now(),
    );
  }
}
