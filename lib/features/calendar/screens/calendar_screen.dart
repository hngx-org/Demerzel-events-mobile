import 'package:flutter/material.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/widgets/calendar_widget.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventProvider = ref.watch(EventProvider.provider);

    return Scaffold(
      // backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
        // backgroundColor: ProjectColors.white,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(height: 1, color: Colors.black),
        ),
        title: const Text('Calendar', style: appBarTextStyle),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.more_vert,
          //     // color: ProjectColors.black,
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: ProjectConstants.bodyPadding,
        child: Column(
          children: [
            const CalCard(),
            ProjectConstants.sizedBox,
            //
            Visibility(
              visible: eventProvider.isBusy,
              child: const Center(child: CircularProgressIndicator()),
            ),

            Visibility(
              visible: eventProvider.error.isNotEmpty,
              child: GestureDetector(
                onTap: () => eventProvider.getEventByDate(
                  DateTime.now(),
                ),
                child: const Text(
                  "Tap to Retry",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),

            if (eventProvider.events != null && !eventProvider.isBusy)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "No event was found",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => eventProvider.getEventByDate(
                        DateTime.now(),
                      ),
                      child: const Text(
                        "Tap to Retry",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const ,
                  itemCount:
                      eventProvider.eventsByDate?.data.events.length ?? 0,
                  itemBuilder: (context, index) {
                    final event =
                        eventProvider.eventsByDate?.data.events[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                event: event!,
                              ),
                            )),
                        child: EventCard(
                          eventTitle: event?.title ?? "N/A",
                          startTime: event?.startTime ?? "N/A",
                          location: event?.location ?? "N/A",
                          endTime: event?.endTime ?? "N/A",
                        ),
                      ),
                    );
                  },
                ),
              ),
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
      decoration: ProjectConstants.appBoxDecoration.copyWith(border: Border.all(color: Theme.of(context).colorScheme.onBackground,)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(eventTitle, style: mediumTextStyle),
              Text(startTime, style: normalTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(location, style: greyTextStyle),
              Text(endTime, style: greyTextStyle),
            ],
          ),
        ]),
      ),
    );
  }
}
