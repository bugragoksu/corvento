import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/model/category.dart';
import 'package:eventapp/src/model/notification.dart';
import 'package:eventapp/src/util/toast_manager.dart';

class FirebaseAPI {
  final Firestore _db = Firestore.instance;
  final ToastManager _toast = ToastManager();

  Future<List<Event>> getAllEvents() async {
    try {
      List<Event> events = List<Event>();
      await _db
          .collection("events")
          .where('date', isGreaterThan: DateTime.now())
          .orderBy("date")
          .getDocuments()
          .then((event) {
        event.documents.forEach((element) {
          if (element.data != null) {
            events.add(Event.fromFirestore(element));
          }
        });
      });
      return events;
    } catch (e) {
      return null;
    }
  }

  Future<List<Event>> search(String text) async {
    List<Event> events = List<Event>();
    List<Event> result = List<Event>();

    await _db
        .collection("events")
        .where('date', isGreaterThan: DateTime.now())
        .orderBy("date")
        .getDocuments()
        .then((event) {
      event.documents.forEach((element) {
        if (element.data != null) {
          events.add(Event.fromFirestore(element));
        }
      });
    });

    events.forEach((event) {
      if (event.title.toLowerCase().contains(text) ||
          event.description.toLowerCase().contains(text)) {
        result.add(event);
      }
    });
    return result;
  }

  Future<List<Event>> getFeaturedEvents() async {
    List<Event> events = List<Event>();
    await _db
        .collection("events")
        .where('featured', isEqualTo: "1")
        .where('date', isGreaterThan: DateTime.now())
        .orderBy("date")
        .getDocuments()
        .then((event) {
      event.documents.forEach((element) {
        if (element.data != null) {
          events.add(Event.fromFirestore(element));
        }
      });
    });
    return events;
  }

  Future<List<Event>> featuredSearch(String text) async {
    try {
      List<Event> events = List<Event>();
      List<Event> result = List<Event>();

      await _db
          .collection("events")
          .where('featured', isEqualTo: "1")
          .where('date', isGreaterThan: DateTime.now())
          .orderBy("date")
          .getDocuments()
          .then((event) {
        event.documents.forEach((element) {
          if (element.data != null) {
            events.add(Event.fromFirestore(element));
          }
        });
      });

      events.forEach((event) {
        if (event.title.toLowerCase().contains(text) ||
            event.description.toLowerCase().contains(text)) {
          result.add(event);
        }
      });
      return result;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      List<Category> categories = List<Category>();
      await _db.collection("categories").getDocuments().then((documents) {
        documents.documents.forEach((category) {
          if (category.data != null) {
            categories.add(Category.fromFirestore(category));
          }
        });
      });
      return categories;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  Future<List<Event>> getEventsByCategory(String category) async {
    try {
      List<Event> events = List<Event>();
      await _db
          .collection("events")
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((event) {
        event.documents.forEach((element) {
          if (element.data != null) {
            events.add(Event.fromFirestore(element));
          }
        });
      });
      return events;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  Future<List<Event>> getBookmarkedEvents(List<String> events) async {
    try {
      List<Event> eventList = List<Event>();
      if (events[0].length > 0) {
        for (var event in events) {
          await _db.collection("events").document(event).get().then((value) {
            if (value.data != null) {
              eventList.add(Event.fromFirestore(value));
            }
          });
        }
      }
      return eventList;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  Future<List<UserNotification>> getNotifications(String uid) async {
    try {
      List<UserNotification> notifications = List<UserNotification>();
      await _db
          .collection("users")
          .document(uid)
          .collection("notifications")
          .where("isRead", isEqualTo: 0)
          .orderBy("date")
          .getDocuments()
          .then((notif) {
        print(notif.documents);
        notif.documents.forEach((element) {
          if (element.data != null) {
            notifications.add(UserNotification.fromFirestore(element));
          }
        });
      });
      return notifications;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  Future<bool> deleteNotification(String uid, String documentID) async {
    try {
      await _db
          .collection("users")
          .document(uid)
          .collection("notifications")
          .document(documentID)
          .updateData({"isRead": "1"});
      return true;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return false;
    }
  }
}
