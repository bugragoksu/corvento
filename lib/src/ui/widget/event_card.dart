import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/event.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  Event event;
  double containerHeight, containerWidth, imageHeigt, imageWidth;
  EventCard(
      {this.event,
      this.containerHeight,
      this.containerWidth,
      this.imageHeigt,
      this.imageWidth});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/eventDetailPage", arguments: event);
      },
      child: Container(
          padding: EdgeInsets.all(5),
          color: appColor,
          height: containerHeight,
          width: containerWidth,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: appColor,
            elevation: 3,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: imageHeigt,
                    width: imageWidth,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          event.imageUrl,
                          fit: BoxFit.fill,
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(
                        event.category.name,
                        style: TextStyle(
                            color: appYellow, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Text(
                          event.title,
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0),
                          child: Text(
                            event.community,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Text(
                            event.getDayNumber() + " " + event.getMonthName(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          )),
    );
  }
}
