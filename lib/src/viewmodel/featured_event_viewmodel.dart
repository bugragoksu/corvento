import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/services/repository/event_repository.dart';
import 'package:flutter/material.dart';

import 'event_viewmodel.dart';

class FeaturedEventViewModel with ChangeNotifier {
  EventState _state;
  EventRepository _repository = EventRepository();
  List<Event> featuredEventList;

  FeaturedEventViewModel() {
    featuredEventList = List<Event>();
    _state = EventState.InitialEventState;
    getFeaturedEvents();
  }
  EventState get state => _state;

  set state(EventState value) {
    _state = value;
    notifyListeners();
  }

  Future<List<Event>> getFeaturedEvents() async {
    try {
      state = EventState.EventLoadingState;
      featuredEventList.clear();
      featuredEventList = await _repository.getFeaturedEvents();
      state = EventState.EventLoadedState;
    } catch (e) {
      state = EventState.EventErrorState;
    }
    return featuredEventList;
  }

  Future<List<Event>> search(String text) async {
    try {
      state = EventState.EventLoadingState;
      featuredEventList.clear();
      featuredEventList = await _repository.searchFeaturedEvents(text);
      state = EventState.EventLoadedState;
    } catch (e) {
      state = EventState.EventErrorState;
    }
    return featuredEventList;
  }
}
