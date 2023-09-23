import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';

import '../services/event/event_service.dart';

final eventServiceProvider = Provider<EventService>((ref) => EventService());

final eventsProvider = FutureProvider<GetListEventModel>((ref) async {
  try {
    final eventService = ref.read(eventServiceProvider);
    return eventService.getAllEvent();
  } catch (e, s) {
    log(e.toString());
    log(s.toString());

    rethrow;
  }
});

// Calender Event
class CalenderEventController extends ChangeNotifier {
  final eventService = EventService();
  GetListEventModel? events;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String _error = "";
  String get error => _error;

  Future<void> getEventByDate(String date) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventService.getEventsByDate(date);

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
}

final calenderEventControllerProvider =
    ChangeNotifierProvider<CalenderEventController>(
  (ref) => CalenderEventController(),
);
