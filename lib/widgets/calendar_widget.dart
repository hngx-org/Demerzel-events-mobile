import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../riverpod/event_provider.dart';

class CalCard extends ConsumerStatefulWidget {
  const CalCard({Key? key}) : super(key: key);

  @override
  ConsumerState<CalCard> createState() => _CalCardState();
}

class _CalCardState extends ConsumerState<CalCard> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getEvents();
      getEventByDate();
    });

    super.initState();
  }

  Future getEvents() async =>
      await ref.read(EventProvider.provider).getAllEvent();

  Future getEventByDate() async => await ref
      .read(EventProvider.provider.notifier)
      .getEventByDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      // height: height * 0.50,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(),
        ),
        child: Padding(
          padding: EdgeInsets.all(height * 0.01),
          child: Column(
            children: [
              TableCalendar(
                rowHeight: 35,
                firstDay: DateTime.now().subtract(const Duration(days: 30)),
                lastDay: DateTime.now().add(const Duration(days: 30)),
                focusedDay: _selectedDay ?? _focusedDay,
                currentDay: _selectedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }

                  ref
                      .read(EventProvider.provider)
                      .getEventByDate(_selectedDay!);
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  markerDecoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                  markerSize: 6,
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                  todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
                eventLoader: (day) {
                  List _events = [];
                  for (var i = 0;
                      i <
                          ref
                              .read(EventProvider.provider)
                              .allEvents!
                              .data
                              .events
                              .length;
                      i++) {
                    if (isSameDay(
                        DateTime.parse(ref
                            .read(EventProvider.provider)
                            .allEvents!
                            .data
                            .events[i]
                            .startDate),
                        day)) {
                      _events.add(ref
                          .read(EventProvider.provider)
                          .allEvents!
                          .data
                          .events[i]);
                    }
                  }
                  return _events;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
