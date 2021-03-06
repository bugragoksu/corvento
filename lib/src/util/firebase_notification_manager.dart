import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationManager {
  FirebaseMessaging _firebaseMessaging;

  FirebaseNotificationManager() {
    this._firebaseMessaging = FirebaseMessaging();
    firebaseMessagingListeners();
  }

  Future<String> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  void firebaseMessagingListeners() {
    getToken();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }
}
