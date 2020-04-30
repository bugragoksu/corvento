import 'package:connectivity/connectivity.dart';
import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/services/local/sharedpref_manager.dart';
import 'package:eventapp/src/ui/widget/event_card.dart';
import 'package:eventapp/src/util/firebase_notification_manager.dart';
import 'package:eventapp/src/util/toast_manager.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:eventapp/src/viewmodel/featured_event_viewmodel.dart';

class HomePage extends StatelessWidget {
  EventViewModel _eventViewModel;
  FeaturedEventViewModel _featuredEventViewModel;
  UserViewModel _userViewModel;
  SharedPrefManager pf = SharedPrefManager();
  bool first = true;
  double height, width;
  ToastManager _toast = ToastManager();

  sendToken() async {
    FirebaseNotificationManager _notif = FirebaseNotificationManager();
    String token = await _notif.getToken();
    _userViewModel.sendFirebaseTokenToServer(token);
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _toast.showMessage(
          "Uygulamayı kullanabilmek için internet bağlantısı gereklidir");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    _eventViewModel = Provider.of<EventViewModel>(context);
    _featuredEventViewModel = Provider.of<FeaturedEventViewModel>(context);
    _userViewModel = Provider.of<UserViewModel>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    if (first) sendToken();
    first = false;
    return Scaffold(
      backgroundColor: appColor,
      appBar: buildAppBar(context),
      body: buildBody(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_eventViewModel.state == EventState.EventLoadingState ||
        _eventViewModel.state == EventState.InitialEventState ||
        _featuredEventViewModel.state == EventState.EventLoadingState) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(iconColor)));
    } else if (_eventViewModel.state == EventState.EventErrorState) {
      return Center(
          child: Icon(FontAwesomeIcons.times, color: Colors.white, size: 32));
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            buildNamesRow(context, "Öne Çıkan Etkinlik", "Tümünü Gör", 1),
            SizedBox(
              height: 5,
            ),
            EventCard(
                event: _featuredEventViewModel.featuredEventList[0],
                containerWidth: double.infinity,
                imageWidth: double.infinity,
                containerHeight: height / 3,
                imageHeigt: height / 5),
            SizedBox(
              height: 10,
            ),
            buildNamesRow(context, "Yaklaşan Etkinlikler", "Tümünü Gör", 2),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _eventViewModel.eventList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EventCard(
                        event: _eventViewModel.eventList[index],
                        containerWidth: width / 1.5,
                        imageWidth: width / 1.5,
                        containerHeight: height / 3.5,
                        imageHeigt: height / 5);
                  }),
            ),
          ],
        ),
      );
    }
  }

  Row buildNamesRow(context, title, showAll, isFeatured) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: textColor, fontSize: 18),
        ),
        Spacer(),
        Container(
          height: 20,
          width: 110,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: () {
              if (isFeatured == 1) {
                Navigator.pushNamed(context, "/featuredEvents");
              } else {
                Navigator.pushNamed(context, "/upcomingEvents");
              }
            },
            color: appYellow,
            child: Text(
              showAll,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar(context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: appColor,
      onTap: (index) async {
        if (index == 1) {
          var events = await pf.getBookmarkedEventList();
          _eventViewModel.getBookmarkedEvents(events);
          Navigator.pushNamed(context, "/bookmarkPage");
        } else if (index == 2) {
          Navigator.pushNamed(context, "/notificationPage");
        } else if (index == 3) {
          Navigator.pushNamed(context, "/contactPage");
        }
      },
      iconSize: 26,
      items: [
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              Icons.home,
              color: iconColor,
            )),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              Icons.bookmark_border,
              color: iconColor,
            )),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              FontAwesomeIcons.bell,
              color: iconColor,
              size: 20,
            )),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: iconColor,
              size: 20,
            )),
      ],
    );
  }

  AppBar buildAppBar(context) => AppBar(
        title: Text(
          "Corvento",
          style: TextStyle(fontFamily: 'Gilroy-Bold', color: textColor),
        ),
        elevation: 0,
        backgroundColor: appColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/categoryPage");
            },
            icon: Icon(FontAwesomeIcons.thLarge, size: 18, color: iconColor),
          ),
        ],
      );
}
