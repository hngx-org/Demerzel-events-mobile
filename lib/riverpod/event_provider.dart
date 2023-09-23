import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:intl/intl.dart';
import '../repositories/event_repository.dart';

class EventController extends ChangeNotifier {
  final EventRepository eventRepository;
  EventController({required this.eventRepository}) {
    getAllEvent();
  }

  GetListEventModel? events;
  GetListEventModel? allEvents;

  static final provider = ChangeNotifierProvider<EventController>((ref) {
    return EventController(eventRepository: ref.read(EventRepository.provider));
  });

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String _error = "";
  String get error => _error;

  Future<void> getAllEvent() async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getAllEvent();
      allEvents = result;
      notifyListeners();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<void> getEventByDate(String date) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getEventsByDate(date);

      events = result;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<bool> createEvent(Map<String, dynamic> body) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await eventRepository.createEvent(body);
      await getAllEvent();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
      return false;
    }

    _isBusy = false;
    notifyListeners();
    return true;
  }
}

/// Calender Event
class CalenderEventsController extends AsyncNotifier<List<Event>> {
  @override
  FutureOr<List<Event>> build() async {
    final event = await ref.watch(EventRepository.provider).getAllEvent();
    return event.data.events;
  }

  void getEventDate(String date) {
    ref.read(eventListProvider.notifier).update((_) =>
        state.value
            ?.where((element) => _filterByDate(element, date))
            .toList() ??
        []);
  }
}

final asyncEventsProvider =
    AsyncNotifierProvider<CalenderEventsController, List<Event>>(() {
  return CalenderEventsController();
});

final eventListProvider = StateProvider<List<Event>>((ref) {
  final allEvents = ref.watch(asyncEventsProvider);
  return allEvents.value
          ?.where((element) =>
              _filterByDate(element, ref.watch(selectedDateProvider)))
          .toList() ??
      [];
});

bool _filterByDate(Event event, String date) {
  return event.startDate.split(" ").first == date;
}

final selectedDateProvider = StateProvider<String>((ref) {
  return DateFormat("yyyy-MM-dd").format(DateTime.now());
});
