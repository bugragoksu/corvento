import 'package:eventapp/src/model/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturedEventCard extends StatelessWidget {
  final Event e;

  FeaturedEventCard({@required this.e});

  @override
  Widget build(BuildContext context) {
    if (e == null) {
      return CircularProgressIndicator();
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/eventDetailPage", arguments: e);
      },
      child: Card(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 160,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          e.imageUrl,
                          fit: BoxFit.fill,
                        )),
                  ),
                  Positioned(
                    top: 95,
                    left: 10,
                    child: featuredEventDateCard(),
                  ),
                  Positioned(
                    right: 10,
                    top: -10,
                    child: Container(
                      width: 40,
                      height: 50,
                      child: Card(
                          color: Colors.yellowAccent.shade700,
                          elevation: 0,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.bookmark,
                                color: Colors.black,
                                size: 20,
                              ))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(e.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.yellowAccent.shade700,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(e.category,
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(e.venue,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(e.getTime(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card featuredEventDateCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0,
      child: Container(
        height: 50,
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              e.getDayNumber(),
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              e.getMonthName(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
