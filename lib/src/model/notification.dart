import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotification {
  final String title;
  final String data;
  final DateTime date;

  UserNotification({this.title, this.data, this.date});

  factory UserNotification.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    return UserNotification(
        title: data["title"] ?? 'Yeni Bildirim',
        data: data['data'] ?? '',
        date: data['date'].toDate() ?? DateTime.now());
  }
}
