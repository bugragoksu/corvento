import 'package:eventapp/src/config/api_settings.dart';
import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/util/toast_manager.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  UserViewModel _userViewModel;
  ToastManager _toast = ToastManager();

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _toast.showMessage('Ops.. Bi şeyler ters gitti');
    }
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          "İletişim",
        ),
        elevation: 0,
        backgroundColor: appColor,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(20),
      height: height,
      color: appColor,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Bizimle iletişime geçin",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: appTransparentColor,
              elevation: 1,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: TextFormField(
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Lütfen bir konu belirtiniz';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                onChanged: (value) {},
                cursorColor: appYellow,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white70),
                    hintText: "Konu",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: appTransparentColor,
              elevation: 1,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Lütfen mesajınızı belirtiniz';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                onChanged: (value) {},
                cursorColor: appYellow,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white70),
                    hintText: "Mesajınız",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
                padding: const EdgeInsets.all(.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  "Gönder",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                color: Colors.yellow.shade700,
                height: 40,
                minWidth: double.infinity,
                onPressed: () async {}),
            Divider(
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    launchURL(instagramUrl);
                  },
                  icon: Icon(FontAwesomeIcons.instagram, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    launchURL(twitterUrl);
                  },
                  icon: Icon(FontAwesomeIcons.twitter, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    launchURL(webUrl);
                  },
                  icon: Icon(FontAwesomeIcons.globe, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: height / 3),
            Center(
              child: Text(
                appName + " " + appVersion,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: MaterialButton(
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}