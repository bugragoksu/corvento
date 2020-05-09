import 'package:eventapp/src/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  final String url, appBarTitle;
  WebViewPage({@required this.url, this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: iconColor,
        ),
        title: Text(appBarTitle, style: TextStyle(color: textColor)),
        elevation: 0,
        backgroundColor: appColor,
      ),
    );
  }
}
