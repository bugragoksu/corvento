import 'package:eventapp/src/services/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/src/model/notification.dart';

enum NotificationState {
  InitialNotificationState,
  NotificationLoadingState,
  NotificationLoadedState,
  NotificationErrorState
}

class NotificationViewModel with ChangeNotifier {
  NotificationState _state;
  NotificationRepository _repository = NotificationRepository();
  List<UserNotification> notificationList;
  final String uid;
  NotificationViewModel({@required this.uid}) {
    notificationList = List<UserNotification>();
    _state = NotificationState.InitialNotificationState;
    getNotifications();
  }

  NotificationState get state => _state;

  set state(NotificationState value) {
    _state = value;
    notifyListeners();
  }

  Future<List<UserNotification>> getNotifications() async {
    try {
      state = NotificationState.NotificationLoadingState;
      notificationList.clear();
      notificationList = await _repository.getNotifications(this.uid);
      state = NotificationState.NotificationLoadedState;
      return notificationList;
    } catch (e) {
      state = NotificationState.NotificationErrorState;
      return [];
    }
  }

  Future<bool> deleteNotification(String documentID) async {
    try {
      state = NotificationState.NotificationLoadingState;
      await _repository.deleteNotification(this.uid, documentID);
      notificationList.clear();
      await _repository.getNotifications(this.uid);
      state = NotificationState.NotificationLoadedState;
      return true;
    } catch (e) {
      return false;
    }
  }
}
