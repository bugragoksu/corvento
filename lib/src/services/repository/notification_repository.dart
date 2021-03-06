import 'package:eventapp/src/model/notification.dart';
import 'package:eventapp/src/services/api/firebase_api.dart';

class NotificationRepository {
  FirebaseAPI _api = FirebaseAPI();
  Future<List<UserNotification>> getNotifications(String uid) async {
    return await _api.getNotifications(uid);
  }

  Future<bool> deleteNotification(String uid, String documentID) async {
    return await _api.deleteNotification(uid, documentID);
  }
}
