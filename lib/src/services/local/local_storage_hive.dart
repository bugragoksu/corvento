import 'package:eventapp/src/model/event.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocalStorageWithHive {
  Box box;

  LocalStorageWithHive() {
    initHive();
  }
  initHive() async {
    try {
      box = await Hive.openBox("evento");
    } catch (e) {
      print(e.toString());
    }
  }

  void setBookMarkEvents(Event event) {
    try {
      if (event != null) {
        List<Event> events = getBookMarksEvents();
        events.add(event);
        box.put("bookmarks", events);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<Event> getBookMarksEvents() {
    List<Event> events = box.get("bookmars");
    return events;
  }
}
