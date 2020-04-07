import 'package:cloud_firestore/cloud_firestore.dart';

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
