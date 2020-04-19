import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/services/local/sharedpref_manager.dart';
import 'package:eventapp/src/util/toast_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as add2calendar;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  EventDetailPage({@required this.event});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool isSaved;
  SharedPrefManager prefManager;
  ToastManager _toast = ToastManager();
  @override
  void initState() {
    prefManager = SharedPrefManager();
    isSaved = false;
    isMarked();
    super.initState();
  }

  saveCalendar() {
    add2calendar.Event event = add2calendar.Event(
        title: widget.event.title,
        startDate: widget.event.date,
        endDate: widget.event.date,
        location: widget.event.venue);
    add2calendar.Add2Calendar.addEvent2Cal(event);
  }

  isMarked() async {
    isSaved = await prefManager.isMarked(widget.event.id);
    setState(() {});
  }

  launchURL() async {
    String url = widget.event.eventUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _toast.showMessage('Could not launch $url');
    }
  }

  clickedBookmars() async {
    if (!isSaved) {
      //ekle

      prefManager.addBookMarkEvents(widget.event.id);
    } else {
      prefManager.deleteEvent(widget.event.id);
    }
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        children: <Widget>[
          Container(
            height: 250,
            child: Image.network(
              widget.event.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: 10,
            top: 30,
            child: Container(
              width: 40,
              height: 50,
              child: Card(
                  color: Colors.yellowAccent.shade700,
                  elevation: 0,
                  child: IconButton(
                      onPressed: () {
                        clickedBookmars();
                      },
                      icon: isSaved
                          ? Icon(
                              FontAwesomeIcons.solidBookmark,
                              color: Colors.black,
                              size: 20,
                            )
                          : Icon(
                              FontAwesomeIcons.bookmark,
                              color: Colors.black,
                              size: 20,
                            ))),
            ),
          ),
          Positioned(
            right: 10,
            top: 80,
            child: Container(
              width: 40,
              height: 50,
              child: Card(
                  color: Colors.yellowAccent.shade700,
                  elevation: 0,
                  child: IconButton(
                      onPressed: () {
                        saveCalendar();
                      },
                      icon: Icon(
                        FontAwesomeIcons.calendarPlus,
                        color: Colors.black,
                        size: 20,
                      ))),
            ),
          ),
          Positioned(
            right: 10,
            top: 130,
            child: Container(
              width: 40,
              height: 50,
              child: Card(
                  color: Colors.yellowAccent.shade700,
                  elevation: 0,
                  child: IconButton(
                      onPressed: () {
                        Share.share(
                          "corvento | Yeni bir etkinlik var! Göz atmak ister misin?\n " +
                              widget.event.title,
                        );
                      },
                      icon: Icon(
                        FontAwesomeIcons.shareAlt,
                        color: Colors.black,
                        size: 20,
                      ))),
            ),
          ),
          SafeArea(
              child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(FontAwesomeIcons.arrowLeft),
                  color: appColor,
                  textColor: Colors.white,
                  minWidth: 0,
                  height: 40,
                  onPressed: () => Navigator.pop(context),
                ),
              ]),
            ),
            SizedBox(
              height: 125,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: appTransparentColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30.0),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.event.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Düzenleyen :",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.event.author.firstName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                LimitedBox(
                                  child: Card(
                                    color: Colors.yellowAccent.shade700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.calendar,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Text(widget.event.getDate(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                LimitedBox(
                                  child: Card(
                                    color: Colors.yellowAccent.shade700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.clock,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Text(widget.event.getTime(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                LimitedBox(
                                  child: Card(
                                    color: Colors.yellowAccent.shade700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Text(widget.event.venue,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Etkinlik Detayı",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.event.desc,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, right: 10),
                              child: Center(
                                child: MaterialButton(
                                  padding: const EdgeInsets.all(.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    "Etkinlik Sitesi",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  color: Colors.yellow.shade700,
                                  height: 40,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    launchURL();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
