import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  UserViewModel _userViewModel;
  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          "Profil",
        ),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Container(
      height: double.infinity,
      color: appColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Text(
              "Yakın zamanda eklenecektir",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(FontAwesomeIcons.shapes, color: Colors.white, size: 36),
            SizedBox(
              height: 275,
            ),
            Text(
              appName + " " + appVersion,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
                padding: const EdgeInsets.all(.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  "Çıkış Yap",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                color: Colors.yellow.shade700,
                height: 40,
                minWidth: 150,
                onPressed: () async {
                  await _userViewModel.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                })
          ],
        ),
      ),
    );
  }
}
