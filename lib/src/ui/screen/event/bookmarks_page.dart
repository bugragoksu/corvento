import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/event_card.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookMarksPage extends StatelessWidget {
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
          color: iconColor,
        ),
        title: Text("Kaydedilenler", style: TextStyle(color: textColor)),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (_eventViewModel.state == EventState.EventLoadingState ||
        _eventViewModel.state == EventState.InitialEventState) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(iconColor)));
    } else if (_eventViewModel.state == EventState.EventErrorState) {
      return Center(
          child: Icon(FontAwesomeIcons.times, color: iconColor, size: 32));
    } else {
      if (_eventViewModel.bookmarkedEventList.length == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Kayıtlı etkinliğiniz bulunmamaktadır",
                style: TextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(FontAwesomeIcons.heartBroken, color: iconColor, size: 36)
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
                    return EventCard(
                        event: _eventViewModel.bookmarkedEventList[index],
                        containerWidth: double.infinity,
                        imageWidth: double.infinity,
                        containerHeight: height / 3,
                        imageHeigt: height / 5);
                  },
                ),
              )
            ],
          ),
        );
      }
    }
  }
}
