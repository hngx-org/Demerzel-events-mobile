
import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';

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
