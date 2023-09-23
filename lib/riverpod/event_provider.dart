import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:intl/intl.dart';
import '../services/event/event_service.dart';

final eventServiceProvider = Provider<EventService>((ref) => EventService());

/// Calender Event
class CalenderEventsController extends AsyncNotifier<List<Event>> {
  @override
  FutureOr<List<Event>> build() async {
    final event = await ref.watch(eventServiceProvider).getAllEvent();
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
          ?.where((element) => _filterByDate(
              element, DateFormat("yyyy-MM-dd").format(DateTime.now())))
          .toList() ??
      [];
});

bool _filterByDate(Event event, String date) {
  return event.startDate.split(" ").first == date;
}
