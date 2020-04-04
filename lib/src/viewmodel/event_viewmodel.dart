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

  EventViewModel() {
    eventList = List<Event>();
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
}
