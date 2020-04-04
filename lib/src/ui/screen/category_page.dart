import 'package:eventapp/src/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColor,
        appBar: AppBar(
          backgroundColor: appColor,
          title: Text(
            "Kategoriler",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Card(
                        color: appTransparentColor,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.terminal,
                                color: Colors.white, size: 36),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Yazılım",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
