import 'package:dio/dio.dart';
import 'package:eventapp/src/config/api_settings.dart';
import 'package:eventapp/src/model/category.dart';
import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/util/toast_manager.dart';

class ServerAPI {
  final ToastManager _toast = ToastManager();

  Future<List<Event>> getAllEvents() async {
    List<Event> events = List<Event>();
    try {
      Response response = await Dio().get(getEventListUrl);
      response.data.forEach((data) {
        if (data != null) {
          events.add(Event.fromJson(data));
        }
      });
      return events;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return events;
    }
  }

  Future<List<Event>> search(String text) async {
    List<Event> events = List<Event>();
    try {
      Response response = await Dio().get(getEventListUrl + "?search=$text");
      response.data.forEach((data) {
        if (data != null) {
          events.add(Event.fromJson(data));
        }
      });
      return events;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return events;
    }
  }

  Future<List<Event>> getBookmarkedEvents(List<String> events) async {
    try {
      List<Event> eventList = List<Event>();
      if (events[0].length > 0) {
        for (var id in events) {
          Response response = await Dio().get(eventUrl + id + "/detail/");
          if (response.data != null) {
            eventList.add(Event.fromJson(response.data));
          }
        }
      }
      return eventList;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return null;
    }
  }

  //----- Categories

  Future<List<Category>> getCategories() async {
    List<Category> categories = List<Category>();
    try {
      Response response = await Dio().get(getCategoriesUrl);
      response.data.forEach((data) {
        if (data != null) {
          categories.add(Category.fromJson(data));
        }
      });
      return categories;
    } catch (e) {
      _toast.localizedMessageFromFirebase(e.code);
      return categories;
    }
  }
}
