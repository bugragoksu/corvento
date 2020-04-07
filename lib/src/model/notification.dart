import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String title;
  final String data;
  final DateTime date;

  Notification({this.title, this.data, this.date});

  factory Notification.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    return Notification(
        title: data["title"] ?? 'Yeni Bildirim',
        data: data['data'] ?? '',
        date: data['date'].toDate() ?? DateTime.now());
  }
}
