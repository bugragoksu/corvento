import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/featuredEventCard.dart';
import 'package:eventapp/src/ui/widget/upcomingEventCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:eventapp/src/viewmodel/featured_event_viewmodel.dart';

class HomePage extends StatelessWidget {
  EventViewModel _eventViewModel;
  FeaturedEventViewModel _featuredEventViewModel;
  @override
  Widget build(BuildContext context) {
    _eventViewModel = Provider.of<EventViewModel>(context);
    _featuredEventViewModel = Provider.of<FeaturedEventViewModel>(context);
    return Scaffold(
      backgroundColor: appColor,
      appBar: buildAppBar(context),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildNamesRow(context, "Öne Çıkan Etkinlik", "Tümünü Gör", 1),
            _featuredEventViewModel.featuredEventList.length > 0
                ? FeaturedEventCard(
                    e: _featuredEventViewModel.featuredEventList[0])
                : CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            buildNamesRow(context, "Yaklaşan Etkinlikler", "Tümünü Gör", 2),
            Expanded(
              child: ListView.builder(
                itemCount: _eventViewModel.eventList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_eventViewModel.state == EventState.EventLoadingState ||
                      _eventViewModel.state == EventState.InitialEventState) {
                    return CircularProgressIndicator();
                  } else if (_eventViewModel.state ==
                      EventState.EventErrorState) {
                    return Icon(FontAwesomeIcons.times,
                        color: Colors.white, size: 32);
                  } else {
                    return UpcomingEventCard(
                        event: _eventViewModel.eventList[index]);
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Row buildNamesRow(context, title, showAll, isFeatured) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Spacer(),
        RaisedButton(
          elevation: 0,
          onPressed: () {
            if (isFeatured == 1) {
              Navigator.pushNamed(context, "/featuredEvents");
            } else {
              Navigator.pushNamed(context, "/upcomingEvents");
            }
          },
          color: appColor,
          child: Text(
            showAll,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar(context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 1) {
          Navigator.pushNamed(context, "/bookmarkPage");
        } else if (index == 2) {
          Navigator.pushNamed(context, "/notificationPage");
        }
      },
      iconSize: 26,
      backgroundColor: appColor,
      items: [
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              Icons.home,
              color: Colors.white,
            )),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.white,
            )),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 20,
            )),
      ],
    );
  }

  AppBar buildAppBar(context) => AppBar(
        title: Text(
          "Event App",
        ),
        elevation: 0,
        backgroundColor: appColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/categoryPage");
            },
            icon: Icon(FontAwesomeIcons.thLarge, size: 18, color: Colors.white),
          ),
        ],
      );
}
