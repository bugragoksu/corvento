import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/widget/notification_card.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/src/viewmodel/notification_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO fix this page
class NotificationPage extends StatelessWidget {
  UserViewModel _userViewModel;
  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context);
    return ChangeNotifierProvider<NotificationViewModel>(
      create: (BuildContext context) =>
          NotificationViewModel(uid: _userViewModel.user.uid),
      child: Scaffold(
        backgroundColor: appColor,
        appBar: AppBar(
          title: Text(
            "Bildirimler",
          ),
          elevation: 0,
          backgroundColor: appColor,
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
    return Consumer<NotificationViewModel>(
        builder: (context, NotificationViewModel viewModel, Widget child) {
      if (viewModel.state == NotificationState.NotificationLoadingState ||
          viewModel.state == NotificationState.InitialNotificationState) {
        return Center(child: CircularProgressIndicator());
      } else if (viewModel.state == NotificationState.NotificationErrorState) {
        return Icon(FontAwesomeIcons.times, color: Colors.white, size: 32);
      } else {
        if (viewModel.notificationList.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Henüz bildirim bulunmamaktadır",
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(FontAwesomeIcons.heartBroken,
                    color: Colors.white, size: 36)
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
                    itemCount: viewModel.notificationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationCard(
                          notification: viewModel.notificationList[index]);
                    },
                  ),
                )
              ],
            ),
          );
        }
      }
    });
  }
}
