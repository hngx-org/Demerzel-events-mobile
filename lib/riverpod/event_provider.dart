import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/riverpod/event_pagination.dart';
import 'package:hng_events_app/riverpod/pagination_state.dart';

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
      final result = await eventRepository.getAllUserEvents(page: 1, limit: 5);
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
      final result = await eventRepository.getAllEvent(page: 1, limit: 5);
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
      final result = await eventRepository.getUpcomingEvent(page: 1, limit: 5);
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

  Future<bool> subscribeToEvent(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    bool result = false;

    final response = await eventRepository.subscribeToEvent(eventId);
    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to subscribe to event',
              result = false
            },
        (r) => result = r);

    if (result) {
      await getAllEvent();
      await getUserEvent();
    }

    _isBusy = false;
    notifyListeners();
    return result;
  }

  Future<bool> unSubscribeFromoEvent(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    bool result = false;

    final response = await eventRepository.unSubscribeToEvent(eventId);
    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to unsubscribe from event',
              result = false
            },
        (r) => result = r);

    if (result) {
      await getAllEvent();
      await getUserEvent();
    }

    _isBusy = false;
    notifyListeners();
    return result;
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

    bool result = false;

    final response = await eventRepository.createEvent(body);

    response.fold(
        (l) => {_error = l.message ?? 'Failed to create event', result = false},
        (r) async => {
              result = r,
              if (groupId != null)
                {await getAllGroupEvent(groupId.toString())}
              else
                {await getAllGroupEvent(body['group_id'][0])}
            });

    _isBusy = false;

    notifyListeners();
    return result;
  }

  bool _isBusyEditingEvent = false;
  bool get isBusyEditingEvent => _isBusyEditingEvent;

  Future<bool> deleteEvent(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    bool result = false;

    final response = await eventRepository.deleteEvent(eventId);

    response.fold(
        (l) => {_error = l.message ?? 'Failed to delete event', result = false},
        (r) => result = r);

    _isBusy = false;
    notifyListeners();
    return result;
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

    bool result = false;

    final response = await eventRepository.editEvent(
        newEventName: newEventName,
        eventID: eventID,
        newEventLocation: newEventLocation,
        newEventDescription: newEventDescription);

    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to update event',
              result = false,
            },
        (r) => result = r);

    _isBusyEditingEvent = false;
    notifyListeners();
    return result;
  }
}

final allEventsProviderOld = FutureProvider<List<Event>>((ref) async {
  EventRepository eventRepository = ref.watch(EventRepository.provider);
  return await eventRepository.getAllEvent(page: 1, limit: 5);
});

final upcomingEventsProviderOld = FutureProvider<List<Event>>((ref) async {
  EventRepository eventRepository = ref.watch(EventRepository.provider);
  return await eventRepository.getUpcomingEvent(page: 1, limit: 5);
});

final userEventsProvider = FutureProvider<List<Event>>((ref) async {
  EventRepository eventRepository = ref.watch(EventRepository.provider);
  return await eventRepository.getAllUserEvents(page: 1, limit: 5);
});

final eventSearchProvider = Provider<List<Event>>((ref) {
  final allEvents = ref.watch(allEventsProviderOld);
  return allEvents.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      data: (data) => data,
      error: (error, stackTrace) => <Event>[],
      loading: () => []);
});

final allEventsProvider =
    StateNotifierProvider<PaginationNotifier<Event>, PaginationState<Event>>(
        (ref) {
  return PaginationNotifier(
    itemsPerBatch: 5,
    fetchNextItems: (page) {
      return ref
          .read(EventRepository.provider)
          .getAllEvent(page: page!, limit: 5);
    },
  )..init();
});

final upcomingEventsProvider =
    StateNotifierProvider<PaginationNotifier<Event>, PaginationState<Event>>(
        (ref) {
  return PaginationNotifier(
    itemsPerBatch: 5,
    fetchNextItems: (page) {
      return ref
          .read(EventRepository.provider)
          .getUpcomingEvent(page: page!, limit: 5);
    },
  )..init();
});

final myEventsProvider =
    StateNotifierProvider<PaginationNotifier<Event>, PaginationState<Event>>(
        (ref) {
  return PaginationNotifier(
    itemsPerBatch: 5,
    fetchNextItems: (page) {
      return ref
          .read(EventRepository.provider)
          .getAllUserEvents(page: page!, limit: 5);
    },
  )..init();
});

