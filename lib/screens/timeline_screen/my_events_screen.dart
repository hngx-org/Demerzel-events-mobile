import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';

import '../../riverpod/event_provider.dart';

class MyEventScreen extends ConsumerWidget {
  const MyEventScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screensize = MediaQuery.of(context).size;
    final eventNotifier = ref.watch(EventProvider.provider);

    if (eventNotifier.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    if (eventNotifier.userEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No event was found", textAlign: TextAlign.center),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => eventNotifier.getUserEvent(),
              child: const Text(
                "Tap to Retry",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => eventNotifier.getAllEvent(),
      child: Visibility(
        visible: eventNotifier.userEvents.isNotEmpty,
        replacement: const SizedBox.shrink(),
        child: ListView.builder(
          itemCount: eventNotifier.userEvents.length,
          itemBuilder: (BuildContext context, int index) {
            final Event event = eventNotifier.userEvents[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentScreen(event: event),
                ),
              ),
              child: TimelineEventCard(
                context: context,
                screensize: screensize,
                image: event.thumbnail,
                title: event.title,
                time: event.startTime,
                location: event.location,
                date: event.startDate,
                activity: DateFormatter().timeLeft(event.startDate, event.startTime),
                onDelete: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
