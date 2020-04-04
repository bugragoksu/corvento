import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/viewmodel/category_viewmodel.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  CategoryViewModel _categoryViewModel;
  EventViewModel _eventViewModel;
  @override
  Widget build(BuildContext context) {
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
    _eventViewModel = Provider.of<EventViewModel>(context);
    return Scaffold(
        backgroundColor: appColor,
        appBar: AppBar(
          backgroundColor: appColor,
          title: Text(
            "Kategoriler",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body());
  }

  Widget body() {
    if (_categoryViewModel.state == CategoryState.CategoryLoadedState) {
      return Container(
        child: Column(
          children: <Widget>[categoryList()],
        ),
      );
    } else if (_categoryViewModel.state == CategoryState.CategoryLoadingState) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(
        child: Icon(FontAwesomeIcons.times, color: Colors.white, size: 46),
      );
    }
  }

  Widget categoryList() {
    return Expanded(
      child: GridView.builder(
          itemCount: _categoryViewModel.categoryList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _eventViewModel.getEventsByCategory(
                    _categoryViewModel.categoryList[index].name);
                Navigator.pushNamed(context, "/eventsbycategoryPage");
              },
              child: Card(
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
                      _categoryViewModel.categoryList[index].name,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
            );
          }),
    );
  }
}
