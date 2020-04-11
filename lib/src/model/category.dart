import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final int id;
  final String name;
  final String icon;

  Category({this.id, this.name, this.icon});

  factory Category.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    return Category(name: data["name"] ?? '');
  }
  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      icon: json["icon"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon": icon
      };
}
