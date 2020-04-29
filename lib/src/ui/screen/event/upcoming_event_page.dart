import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/event_card.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpcomingEventsPage extends StatelessWidget {
  TextEditingController _editingController = TextEditingController();
  EventViewModel _eventViewModel;
  double height;
  @override
  Widget build(BuildContext context) {
    _eventViewModel = Provider.of<EventViewModel>(context);
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: iconColor, //change your color here
        ),
        title: Text("Yaklaşan Etkinlikler", style: TextStyle(color: textColor)),
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
                    return CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(iconColor));
                  } else if (_eventViewModel.state ==
                      EventState.EventErrorState) {
                    return Icon(FontAwesomeIcons.times,
                        color: iconColor, size: 32);
                  } else {
                    return EventCard(
                        event: _eventViewModel.eventList[index],
                        containerWidth: double.infinity,
                        imageWidth: double.infinity,
                        containerHeight: height / 3,
                        imageHeigt: height / 5);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // Row datesRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: <Widget>[
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: appColor,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: textColor),
  //               ),
  //               Text("Pzt", style: TextStyle(color: textColor))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: appColor,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               Text("Pzt", style: TextStyle(color: Colors.white))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: Colors.yellowAccent.shade700,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               Text("Pzt", style: TextStyle(color: Colors.black))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: appColor,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               Text("Pzt", style: TextStyle(color: Colors.white))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: appColor,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               Text("Pzt", style: TextStyle(color: Colors.white))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: appColor,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               Text("Pzt", style: TextStyle(color: Colors.white))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 45,
  //         height: 60,
  //         child: Card(
  //           color: appColor,
  //           elevation: 0,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(
  //                 "16",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               Text("Pzt", style: TextStyle(color: Colors.white))
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Padding searchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: appColor,
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: TextField(
          style: TextStyle(
            color: textColor,
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
              hintStyle: TextStyle(color: textColor),
              prefixIcon: Icon(
                Icons.search,
                color: iconColor,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}
