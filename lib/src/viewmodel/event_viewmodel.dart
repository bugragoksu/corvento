import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/services/repository/event_repository.dart';
import 'package:flutter/material.dart';

enum EventState {
  InitialEventState,
  EventLoadingState,
  EventLoadedState,
  EventErrorState
}

class EventViewModel with ChangeNotifier {
  EventState _state;
  EventRepository _repository = EventRepository();
  List<Event> eventList;
  List<Event> eventListByCategory;
  List<Event> bookmarkedEventList;

  EventViewModel() {
    eventList = List<Event>();
    eventListByCategory = List<Event>();
    bookmarkedEventList = List<Event>();
    _state = EventState.InitialEventState;
    getAllEvents();
  }

  EventState get state => _state;

  set state(EventState value) {
    _state = value;
    notifyListeners();
  }

  Future<List<Event>> search(String text) async {
    try {
      state = EventState.EventLoadingState;
      eventList.clear();
      eventList = await _repository.searchEvent(text);
      state = EventState.EventLoadedState;
    } catch (e) {
      state = EventState.EventErrorState;
    }
    return eventList;
  }

  Future<List<Event>> getAllEvents() async {
    try {
      state = EventState.EventLoadingState;
      eventList.clear();
      eventList = await _repository.getAllEvents();
      state = EventState.EventLoadedState;
    } catch (e) {
      state = EventState.EventErrorState;
    }
    return eventList;
  }

  Future<List<Event>> getEventsByCategory(String category) async {
    try {
      state = EventState.EventLoadingState;
      eventListByCategory.clear();
      eventListByCategory = await _repository.getEventsByCategory(category);
      state = EventState.EventLoadedState;
    } catch (e) {
      state = EventState.EventErrorState;
    }
    return eventListByCategory;
  }

  Future<List<Event>> getBookmarkedEvents(List<String> events) async {
    try {
      state = EventState.EventLoadingState;
      bookmarkedEventList.clear();
      bookmarkedEventList = await _repository.getBookmarkedEvents(events);
      state = EventState.EventLoadedState;
    } catch (e) {
      state = EventState.EventErrorState;
    }
    return bookmarkedEventList;
  }
}
