import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/services/local/sharedpref_manager.dart';
import 'package:eventapp/src/util/toast_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _toast.showMessage(
          'Ops. Bi şeyler ters gitti. Daha sonra tekrar deneyiniz');
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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appColor,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Stack(
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
                    color: Colors.transparent,
                    elevation: 0,
                    child: IconButton(
                        onPressed: () {
                          clickedBookmars();
                        },
                        icon: isSaved
                            ? Icon(
                                FontAwesomeIcons.solidBookmark,
                                color: iconColor,
                                size: 20,
                              )
                            : Icon(
                                FontAwesomeIcons.bookmark,
                                color: iconColor,
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
                    color: Colors.transparent,
                    elevation: 0,
                    child: IconButton(
                        onPressed: () {
                          saveCalendar();
                        },
                        icon: Icon(
                          FontAwesomeIcons.calendarPlus,
                          color: iconColor,
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
                    color: Colors.transparent,
                    elevation: 0,
                    child: IconButton(
                        onPressed: () {
                          Share.share(
                              "Corvento | Yeni bir etkinlik var! Göz atmak ister misin?\n " +
                                  widget.event.title +
                                  "\n" +
                                  "http://corvento.com/");
                        },
                        icon: Icon(
                          FontAwesomeIcons.shareAlt,
                          color: iconColor,
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
                    textColor: textColor,
                    minWidth: 0,
                    height: 40,
                    onPressed: () => Navigator.pop(context),
                  ),
                ]),
              ),
              SizedBox(
                height: 125,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  height: height / 1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: appColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          widget.event.title,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Düzenleyen :",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.event.community,
                            style: TextStyle(
                              color: Colors.grey,
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
                              elevation: 2,
                              color: appColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      color: iconColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(widget.event.getDate(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                        ),
                                        overflow: TextOverflow.ellipsis)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          LimitedBox(
                            child: Card(
                              elevation: 2,
                              color: appColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      color: iconColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(widget.event.getTime(),
                                        style: TextStyle(
                                            fontSize: 16, color: textColor),
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          LimitedBox(
                            child: Card(
                              elevation: 2,
                              color: appColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      color: iconColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(widget.event.venue,
                                        style: TextStyle(
                                            fontSize: 16, color: textColor),
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
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: <Widget>[
                            Html(
                              data: widget.event.description,
                              onLinkTap: (String link) {
                                launchURL(link);
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                        child: Center(
                          child: MaterialButton(
                            padding: const EdgeInsets.all(.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              "Etkinlik Sitesi",
                              style: TextStyle(
                                fontSize: 20,
                                color: textColor,
                              ),
                            ),
                            color: appYellow,
                            height: 40,
                            minWidth: double.infinity,
                            onPressed: () {
                              launchURL(widget.event.eventUrl);
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            ]))
          ],
        ),
      ),
    );
  }
}
