import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:eventapp/src/ui/widget/upcoming_event_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpcomingEventsPage extends StatelessWidget {
  TextEditingController _editingController = TextEditingController();
  EventViewModel _eventViewModel;
  @override
  Widget build(BuildContext context) {
    _eventViewModel = Provider.of<EventViewModel>(context);
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          "Yaklaşan Etkinlikler",
        ),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            searchBox(),
            SizedBox(
              height: 20,
            ),
            // datesRow(),
            // SizedBox(
            //   height: 20,
            // ),
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
    );
  }

  Row datesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: appColor,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Pzt", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: appColor,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Pzt", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: Colors.yellowAccent.shade700,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Pzt", style: TextStyle(color: Colors.black))
              ],
            ),
          ),
        ),
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: appColor,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Pzt", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: appColor,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Pzt", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: appColor,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Pzt", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Container(
          width: 45,
          height: 60,
          child: Card(
            color: appColor,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "16",
                  style: TextStyle(color: Colors.white),
                ),
                Text("Pzt", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Material searchBox() {
    return Material(
      color: appTransparentColor,
      elevation: 1,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: _editingController,
        cursorColor: appYellow,
        onChanged: (value) {
          if (value.length >= 3) {
            _eventViewModel.search(value.trim());
          }
          if (value.length == 0) {
            _eventViewModel.getAllEvents();
          }
        },
        decoration: InputDecoration(
            hintText: "Ara",
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
      ),
    );
  }
}
