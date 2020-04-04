import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/upcomingEventCard.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EventByCategoryPage extends StatelessWidget {
  TextEditingController _editingController = TextEditingController();
  EventViewModel _eventViewModel;
  @override
  Widget build(BuildContext context) {
    _eventViewModel = Provider.of<EventViewModel>(context);
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          "Etkinlikler",
        ),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: (_eventViewModel.eventListByCategory.length == 0)
          ? isEmptyList()
          : Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _eventViewModel.eventListByCategory.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_eventViewModel.state ==
                                EventState.EventLoadingState ||
                            _eventViewModel.state ==
                                EventState.InitialEventState) {
                          return CircularProgressIndicator();
                        } else if (_eventViewModel.state ==
                            EventState.EventErrorState) {
                          return Icon(FontAwesomeIcons.times,
                              color: Colors.white, size: 32);
                        } else {
                          return UpcomingEventCard(
                              event:
                                  _eventViewModel.eventListByCategory[index]);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Center isEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Üzgünüz, bu kategoride henüz",
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "etkinlik bulunmamaktadır.",
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
  }
}
