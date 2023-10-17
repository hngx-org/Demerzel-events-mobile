import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/models/group.dart';

import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository eventRepository;

  EventProvider({required this.eventRepository}) {
    getUpcomingEvent();
    getUserEvent();
  }

  GetListEventModel? events;
  GetListEventModel? eventsByDate;
  List<Event> allEvents = [];
  GroupEventListModel? allGroupEvents;
  List<Event> userEvents = [];
  List<Event> upcomingEvents = [];

  static final provider = ChangeNotifierProvider<EventProvider>((ref) {
    return EventProvider(eventRepository: ref.watch(EventRepository.provider));
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

    _isBusy = false;
    notifyListeners();
  }

  Future<void> getUpcomingEvent() async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getUpcomingEvent();
      upcomingEvents = result;
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

  Future<void> subscribeToEvent(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await eventRepository.subscribeToEvent(eventId);
      await getAllEvent();
      await getUserEvent();
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

  Future<bool> createEvent(
      {required Map<String, dynamic> body, String? groupId}) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await eventRepository.createEvent(body);
      await getAllGroupEvent(groupId.toString());
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

  bool _isBusyEditingEvent = false;
  bool get isBusyEditingEvent => _isBusyEditingEvent;

//   Future<bool> deleteEvent(String eventId) async {
//     _isBusy = true;
//     _error = "";
//     notifyListeners();

//     try {
//      final result = await eventRepository.deleteEvent(eventId);
//      if (result) {
//        _isBusy = false;
//        await getAllEvent();
//       await getUserEvent();
//       notifyListeners();
//       return true;
//      }else{
//       _error = "Couldn't delete Event";
//        _isBusy = false;
//         notifyListeners();
//        return false;
//      }
      
//     } catch (e, s) {
//       log(e.toString());
//       log(s.toString());
//      // _error = e.toString();
// return false;
//     }
    
   
//   }

  Future<bool> deleteEvent(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
    final result = await eventRepository.deleteEvent(eventId);
      if (result) {
        await getUserEvent();
         await getAllEvent();
        _isBusy = false;
        notifyListeners();
        return true;
      } else {
        _isBusy = false;
        notifyListeners();
        return false;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      _isBusy = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }

    // notifyListeners();
    // return true;
  }

  Future<bool> editEvent({
    required String newEventName,
    required String eventID,
    required String newEventLocation,
    required String newEventDescription,
  }) async {
    _isBusyEditingEvent = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.editEvent(
          newEventName: newEventName,
          eventID: eventID,
          newEventLocation: newEventLocation,
          newEventDescription: newEventDescription);

     
      if (result) {
        _isBusyEditingEvent = false;
        notifyListeners();
        return true;
      } else {
        _isBusy = false;
        _isBusyEditingEvent = false;
        _error = 'Failed to update event';
        notifyListeners();
        return false;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}

final allEventsProvider = FutureProvider<List<Event>>((ref) async {
  EventRepository eventRepository = ref.watch(EventRepository.provider);
  return await eventRepository.getAllEvent();
});

final upcomingEventsProvider = FutureProvider<List<Event>>((ref) async {
  EventRepository eventRepository = ref.watch(EventRepository.provider);
  return await eventRepository.getUpcomingEvent();
});

final userEventsProvider = FutureProvider<List<Event>>((ref) async {
  EventRepository eventRepository = ref.watch(EventRepository.provider);
  return await eventRepository.getAllUserEvents();
});

final eventSearchProvider = Provider<List<Event>>((ref) {
  final allEvents = ref.watch(allEventsProvider);
  return allEvents.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      data: (data) => data,
      error: (error, stackTrace) => <Event>[],
      loading: () => []);
});
