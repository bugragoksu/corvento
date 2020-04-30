import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/notification.dart';
import 'package:eventapp/src/viewmodel/notification_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NotificationCard extends StatelessWidget {
  final UserNotification notification;

  const NotificationCard({
    Key key,
    @required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationViewModel notificationViewModel =
        Provider.of<NotificationViewModel>(context);
    return Container(
      color: appColor,
      height: 75,
      child: Card(
        color: appYellow,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.infoCircle,
                color: iconColor,
                size: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                notification.title + " :",
                style: TextStyle(color: textColor, fontSize: 14),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  notification.data,
                  style: TextStyle(color: textColor, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  notificationViewModel
                      .deleteNotification(notification.documentID);
                },
                icon:
                    Icon(FontAwesomeIcons.trashAlt, color: iconColor, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
