import 'package:flutter/material.dart';
import 'package:hng_events_app/shared/colors.dart';
import 'package:hng_events_app/shared/widgets/calendar_widget.dart';

import '../shared/constants.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ProjectColors.bgColor,
      appBar: AppBar(
        centerTitle: false,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              height: 1,
              color: Colors.black,
            )),
        title: const Text('Calendar'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: const Padding(
        padding: kBodyPadding,
        child: Column(
          children: [
            CalCard(),
            kSizedBox,
            //TODO: change hardcoded data to data from backend
            EventCard(
              eventTitle: 'Movie Night',
              startTime: '8:30 PM',
              location: 'Genesis Cinema, Festac',
              endTime: '9:45 PM',
            )
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventTitle, startTime, location, endTime;
  const EventCard({
    super.key,
    required this.eventTitle,
    required this.startTime,
    required this.location,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kAppBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(eventTitle),
              Text(startTime),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(location),
              Text(endTime),
            ],
          ),
        ]),
      ),
    );
  }
}
