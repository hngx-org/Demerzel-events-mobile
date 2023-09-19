import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class CalCard extends StatefulWidget {
  const CalCard({Key? key}) : super(key: key);

  @override
  State<CalCard> createState() => _CalCardState();
}

class _CalCardState extends State<CalCard> {
  
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return SizedBox(
       // height: height * 0.50,
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),side: const BorderSide()),
          child: Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Column(
              children: [
                TableCalendar(
                  rowHeight: 35,
                 
                  firstDay: DateTime.now().subtract(const Duration(days: 30)),
                  lastDay: DateTime.now().add(const Duration(days: 30)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                  calendarFormat: CalendarFormat.month,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(

                    todayDecoration: BoxDecoration(
                      color: Colors.red,
                      // shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(8),
                      // ),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      // shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(8),
                      // ),
                    ),

                  ),
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(20.0),
                            ),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                    todayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular()
                            ),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
