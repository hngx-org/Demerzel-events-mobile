import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/screens/timeline_screen/my_events_screen.dart';

import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository eventRepository;
  EventProvider({required this.eventRepository}) {
    getAllEvent();
    getUserEvent();
    getUpcomingEvent();
  }

  GetListEventModel? events;
  GetListEventModel? eventsByDate;
  GetListEventModel? allEvents;
  GetListEventModel? allGroupEvents;
  List<Event> userEvents = [];
  List<Event> upcomingEvents = [];

  static final provider = ChangeNotifierProvider<EventProvider>((ref) {
    return EventProvider(eventRepository: ref.read(EventRepository.provider));
  });

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String _error = "";
  String get error => _error;

  Future<void> getUserEvent() async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getAllUserEvents();
      userEvents = result;
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

    print('-------------> called ${allEvents?.data.events.length}');

    _isBusy = false;
    notifyListeners();
  }
  Future<void> getUpcomingEvent() async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getUpcomingEvent();
      allEvents = result;
      notifyListeners();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
    }

    print('-------------> called ${allEvents?.data.events.length}');

    _isBusy = false;
    notifyListeners();
  }

  // Future<void> getUpcomingEvent() async {
  //   _isBusy = true;
  //   _error = "";
  //   notifyListeners();
  //   final newUpcoming = <Event>[];
  //   try {
  //     final result = await eventRepository.getAllEvent();
  //     allEvents = result;

  //     if (upcomingEvents.isEmpty) {
  //       upcomingEvents.addAll(allEvents!.data.events.where((event) =>
  //           timeLeft(
  //            event.startDate, event.startTime
  //           ) !=
  //           'Expired'));
  //     } else {
  //       newUpcoming.addAll(allEvents!.data.events.where((event) =>
  //           timeLeft(
  //            event.startDate, event.startTime
  //           ) !=
  //           'Expired'));
  //       for (var i = 0; i < newUpcoming.length; i++) {
  //         if (!upcomingEvents.contains(newUpcoming[i])) {
  //           upcomingEvents.add(newUpcoming[i]);
  //         }
  //       }
  //     }


  //     log(upcomingEvents.toString());
  //     notifyListeners();
  //   } catch (e, s) {
  //     log(e.toString());
  //     log(s.toString());

  //     _error = e.toString();
  //     notifyListeners();
  //   }

  //   _isBusy = false;
  //   notifyListeners();
  // }

  Future<void> subscribeToEvent(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await eventRepository.subscribeToEvent(eventId);
      await getAllEvent();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<void> getAllGroupEvent(String groupId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getAllGroupEvent(groupId);
      allGroupEvents = result;
      
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

  Future<void> getEventByDate(DateTime date) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getEventsByDate(date);

      eventsByDate = result;
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
