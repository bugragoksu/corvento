import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/upcomingEventCard.dart';
import 'package:flutter/material.dart';

class BookMarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          "Kaydedilenler",
        ),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return UpcomingEventCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
