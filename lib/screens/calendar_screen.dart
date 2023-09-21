import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/widgets/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.white,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            height: 1,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Calendar',
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: ProjectColors.black,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: ProjectConstants.bodyPadding,
        child: Column(
          children: [
            CalCard(),
            ProjectConstants.sizedBox,
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
      decoration: ProjectConstants.appBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                eventTitle,
                style: mediumTextStyle,
              ),
              Text(
                startTime,
                style: normalTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location,
                style: greyTextStyle,
              ),
              Text(endTime, style: greyTextStyle),
            ],
          ),
        ]),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CalendarScreen extends StatefulWidget {
//   const CalendarScreen({super.key});
//   @override
//   State<CalendarScreen> createState() => _CalendarScreenState();
// }
// class _CalendarScreenState extends State<CalendarScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Text("Calendar");
//   }
// }