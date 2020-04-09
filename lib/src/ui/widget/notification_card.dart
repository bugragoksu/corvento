import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationCard extends StatelessWidget {
  final UserNotification notification;
  const NotificationCard({
    Key key,
    @required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor,
      height: 75,
      child: Card(
        color: appTransparentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                notification.title + " :",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  notification.data,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.trashAlt,
                    color: Colors.white, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
