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
  String subject, message;
  final _feedbackFormKey = GlobalKey<FormState>();

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
        iconTheme: IconThemeData(
          color: iconColor,
        ),
        title: Text("İletişim", style: TextStyle(color: textColor)),
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
        child: Form(
          key: _feedbackFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bizimle iletişime geçin",
                style: TextStyle(color: textColor, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: appColor,
                  elevation: 2,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Lütfen bir konu belirtiniz';
                      }
                      return null;
                    },
                    style: TextStyle(color: textColor),
                    onChanged: (value) {
                      subject = value;
                    },
                    cursorColor: appYellow,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: textColor),
                        hintText: "Konu",
                        hintStyle: TextStyle(color: textColor, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: appColor,
                  elevation: 2,
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
                    style: TextStyle(color: textColor),
                    onChanged: (value) {
                      message = value;
                    },
                    cursorColor: appYellow,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: textColor),
                        hintText: "Mesajınız",
                        hintStyle: TextStyle(color: textColor, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _userViewModel.state != UserState.Busy
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            "Gönder",
                            style: TextStyle(
                              fontSize: 20,
                              color: textColor,
                            ),
                          ),
                          color: appYellow,
                          height: 40,
                          minWidth: double.infinity,
                          onPressed: () async {
                            if (_feedbackFormKey.currentState.validate()) {
                              await _userViewModel.sendFeedback(
                                  subject, message);
                            }
                          })
                      : Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(iconColor)),
                        )),
              Divider(
                color: iconColor,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      launchURL(instagramUrl);
                    },
                    icon: Icon(FontAwesomeIcons.instagram, color: iconColor),
                  ),
                  IconButton(
                    onPressed: () {
                      launchURL(twitterUrl);
                    },
                    icon: Icon(FontAwesomeIcons.twitter, color: iconColor),
                  ),
                  IconButton(
                    onPressed: () {
                      launchURL(webUrl);
                    },
                    icon: Icon(FontAwesomeIcons.globe, color: iconColor),
                  ),
                ],
              ),
              SizedBox(height: height / 4.5),
              Center(
                child: Text(
                  appName + " | " + appVersion,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: textColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: textColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ]),
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
                        color: textColor,
                      ),
                    ),
                    color: appYellow,
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
      ),
    );
  }
}
