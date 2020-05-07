import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPreferences prefs;

  setEvent(String event) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("bookmarks", event);
  }

  addBookMarkEvents(String event) async {
    try {
      if (event != null) {
        String events = await getBookMarksEvents();
        if (events == "") {
          events = event;
        } else {
          events += ",$event";
        }
        setEvent(events);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getBookMarksEvents() async {
    prefs = await SharedPreferences.getInstance();
    String events = prefs.getString('bookmarks');

    if (events == null) {
      return "";
    }
    return events;
  }

  deleteEvent(String event) async {
    try {
      String events = await getBookMarksEvents();
      if (events != "") {
        List<String> eventList = events.split(',');
        eventList.remove(event);
        events = eventList.toString();
        events = events.replaceAll("[", "");
        events = events.replaceAll("]", "");
        setEvent(events);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> isMarked(String event) async {
    String events = await getBookMarksEvents();
    if (events != null) {
      List<String> eventList = events.split(',');
      bool result = eventList.contains(event);
      return result;
    } else {
      return false;
    }
  }

  Future<List<String>> getBookmarkedEventList() async {
    String events = await getBookMarksEvents();
    return events.split(',');
  }
}
