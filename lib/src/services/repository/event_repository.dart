import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/services/api/firebase_api.dart';

class EventRepository {
  FirebaseAPI _api = FirebaseAPI();

  Future<List<Event>> searchEvent(String text) async {
    return await _api.search(text);
  }

  Future<List<Event>> getAllEvents() async {
    return await _api.getAllEvents();
  }

  Future<List<Event>> getFeaturedEvents() async {
    return await _api.getFeaturedEvents();
  }

  Future<List<Event>> searchFeaturedEvents(String text) async {
    return await _api.featuredSearch(text);
  }

  Future<List<Event>> getEventsByCategory(String category) async {
    return await _api.getEventsByCategory(category);
  }

  Future<List<Event>> getBookmarkedEvents(List<String> events) async {
    return await _api.getBookmarkedEvents(events);
  }
}
