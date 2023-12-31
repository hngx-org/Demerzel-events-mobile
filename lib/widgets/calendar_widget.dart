import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
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
final allEvents = ref.watch(EventProvider.provider).allEvents;
    return SizedBox(
      height: height * 0.45,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(height * 0.01),
          child: Column(
            children: [
              MediaQuery(
                 data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: TableCalendar(
                  pageJumpingEnabled: true,
                  rowHeight: MediaQuery.sizeOf(context).height * 0.05,
                  firstDay: DateTime.now().subtract(const Duration(days: 500)),
                  lastDay: DateTime.now().add(const Duration(days: 1500)),
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
                    todayDecoration: const BoxDecoration(color: ProjectColors.purple),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    markerDecoration: const BoxDecoration(
                        color: ProjectColors.purple, shape: BoxShape.circle),
                    markerSize: 6,
                  ),
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          //color: Theme.of(context).colorScheme.onBackground,
                          border: Border.all(
                            color: ProjectColors.purple,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground),
                        )),
                    todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ProjectColors.purple,
                        ),
                        // color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  eventLoader: (day) => allEvents
                      .where((event) =>
                          isSameDay(DateTime.tryParse(event.startDate), day))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
