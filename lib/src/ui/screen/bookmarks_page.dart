import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/upcoming_event_card.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookMarksPage extends StatelessWidget {
  EventViewModel _eventViewModel;
  @override
  Widget build(BuildContext context) {
    _eventViewModel = Provider.of<EventViewModel>(context);
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          "Kaydedilenler",
        ),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (_eventViewModel.bookmarkedEventList.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Kayıtlı etkinliğiniz bulunmamaktadır",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 20,
            ),
            Icon(FontAwesomeIcons.heartBroken, color: Colors.white, size: 36)
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _eventViewModel.bookmarkedEventList.length,
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
                        event: _eventViewModel.bookmarkedEventList[index]);
                  }
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
