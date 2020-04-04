import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;

  Category({this.name});

  factory Category.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    return Category(name: data["name"] ?? '');
  }
}
