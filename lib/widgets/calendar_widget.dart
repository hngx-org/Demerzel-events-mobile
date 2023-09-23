import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    super.initState();
  }

  List<Event> _getEventsForDay(DateTime day) {
    final events = ref.watch(asyncEventsProvider);
    final data = DateFormat("yyyy-MM-dd").format(day);
    return events.value
            ?.where((element) => element.startDate == data)
            .toList() ??
        [];
  }

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
                eventLoader: _getEventsForDay,
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
                  ref.read(asyncEventsProvider.notifier).getEventDate(
                      DateFormat("yyyy-MM-dd").format(_focusedDay));
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                      color: ProjectColors.purple, shape: BoxShape.circle),
                  markersMaxCount: 1,
                  todayDecoration: BoxDecoration(color: ProjectColors.purple),
                  selectedDecoration: BoxDecoration(
                    color: ProjectColors.purple,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: ProjectColors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                  todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: ProjectColors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
