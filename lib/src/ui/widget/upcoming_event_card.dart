import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpcomingEventCard extends StatelessWidget {
  final Event event;
  UpcomingEventCard({@required this.event});
  double height, width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/eventDetailPage", arguments: this.event);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: width / 2,
        color: appColor,
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: appTransparentColor,
          child: Row(
            children: <Widget>[
              Container(
                width: 125,
                height: height / 4,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      event.imageUrl,
                      fit: BoxFit.fill,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        event.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.calendar,
                            color: iconColor,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(event.getDate(),
                              style: TextStyle(fontSize: 12, color: textColor))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.clock,
                            color: iconColor,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(event.getTime(),
                              style: TextStyle(fontSize: 12, color: textColor))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: iconColor,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(event.venue,
                              style: TextStyle(fontSize: 12, color: textColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
