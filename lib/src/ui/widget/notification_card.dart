import 'package:eventapp/src/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key key,
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
                size: 22,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Yeni Etkinlik :",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "WTM Mersin IWD'20",
                  style: TextStyle(color: Colors.white, fontSize: 12),
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
