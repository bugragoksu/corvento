import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/ui/screen/auth/sign_page.dart';
import 'package:eventapp/src/ui/screen/home_page.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  UserViewModel _userViewModel;
  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context);
    if (_userViewModel.state == UserState.Idle) {
      if (_userViewModel.user == null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/sign", (Route<dynamic> route) => false);
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/home", (Route<dynamic> route) => false);
        });
      }
    }
    return Container(
        color: appColor, child: Center(child: CircularProgressIndicator()));
  }
}
