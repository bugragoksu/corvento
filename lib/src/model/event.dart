import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/src/model/author.dart';
import 'package:eventapp/src/model/category.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Event {
  final String id;
  final String title;
  final String description;
//  final String category;
  final DateTime date;
  final String eventUrl;
  final String imageUrl;
  final String venue;
  // final String author;
  final Author author;
  final Category category;
  final String community;
  Event(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.date,
      this.eventUrl,
      this.imageUrl,
      this.venue,
      this.author,
      this.community});

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return Event(
        id: doc.documentID,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        category: data['category'] ?? '',
        date: data['date'].toDate() ?? DateTime.now(),
        eventUrl: data['eventUrl'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        venue: data['venue'] ?? '',
        author: data['author'] ?? '');
  }

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["slug"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        imageUrl: json["image"] ?? '',
        eventUrl: json["event_url"] ?? '',
        venue: json["venue"] ?? '',
        community: json['community'] ?? '',
        date: DateTime.parse(json['date']).toLocal() ?? DateTime.now(),
        category: Category.fromJson(json["category"]) ?? null,
        author: Author.fromJson(json["author"]) ?? null,
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? '',
        "description": description ?? '',
        "image": imageUrl ?? '',
        "venue": venue ?? '',
        "date": date ?? DateTime.now(),
        "category": category.toJson() ?? null,
        "author": author.toJson() ?? null,
      };

  String getDate() {
    initializeDateFormatting('tr');
    return DateFormat.yMd('tr').format(this.date);
  }

  String getTime() {
    return DateFormat('jm', 'tr').format(this.date);
  }

  String getDayNumber() {
    return getDate().split('.')[0]; //30.01.2020 -> 30
  }

  String getMonthName() {
    var monthNumber = getDate().split('.')[1].toString(); //30.01.2020 -> 01

    switch (monthNumber) {
      case '01':
        return 'Ocak';
        break;
      case '02':
        return 'Şub';
        break;
      case '03':
        return 'Mar';
        break;
      case '04':
        return 'Nis';
        break;
      case '05':
        return 'May';
        break;
      case '06':
        return 'Haz';
        break;
      case '07':
        return 'Tem';
        break;
      case '08':
        return 'Agu';
        break;
      case '09':
        return 'Eyl';
        break;
      case '10':
        return 'Eki';
        break;
      case '1':
        return 'Kas';
        break;
      case '12':
        return 'Ara';
        break;
      default:
        return '';
    }
  }
}
