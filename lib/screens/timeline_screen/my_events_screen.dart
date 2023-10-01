import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';

import '../../riverpod/event_provider.dart';

class MyEventScreen extends ConsumerWidget {
  final Key key;
  const MyEventScreen({required this.key});

  Widget bodyBuild(String title, String specifictime, String date,
      String location, String time, String image) {
    return GestureDetector(
      child: Container(
        height: 150.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ProjectColors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              color: ProjectColors.black,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          border: Border.all(color: ProjectColors.black, width: 1),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: image.isEmpty,
                    replacement: Image.network(
                      image,
                      fit: BoxFit.contain,
                      width: 100.r,
                      height: 100.r,
                    ),
                    child: Image.asset(
                      'assets/images/emoji.png',
                      fit: BoxFit.contain,
                      width: 100.r,
                      height: 100.r,
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24.h)),
                        SizedBox(height: 6.h),
                        Text(date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.r)),
                        Text(specifictime,
                            style: TextStyle(
                                fontSize: 12.r, color: ProjectColors.grey)),
                        SizedBox(height: 6.h),
                        Text(location,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.r)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Column(
                    children: [Icon(Icons.more_vert), Spacer()],
                  )
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.r,
                    color: ProjectColors.purple,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

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
                activity: timeLeft(event.startDate, event.startTime),
              ),
            );
          },
        ),
      ),
    );
  }
}

String timeLeft(String startDate, String startTime) {
  //final formatter =DateFormat('HH:mm');
  final DateTime date;

  if (RegExp(r'^[0-9]{2}:[0-9]$').hasMatch(startTime)) {
    startTime = '${startTime.substring(0, 3)}0${startTime.substring(3)}';
    date = DateTime.parse("${startDate}T$startTime");
  } else if (RegExp('^[0-9]:[0-9]{2}').hasMatch(startTime)) {
    startTime = '0${startTime.substring(0)}';
    date = DateTime.parse("${startDate}T$startTime");
  } else {
    date = DateTime.parse("${startDate}T$startTime");
  }

  final date2 = DateTime.now();
  final difference = date.difference(date2);

  if ((difference.inDays / 7).floor() >= 1) {
    return '1 week Left';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days Left';
  } else if (difference.inDays >= 1) {
    return '1 day Left';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours Left';
  } else if (difference.inHours >= 1) {
    return '1 hour Left';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes Left';
  } else if (difference.inMinutes >= 1) {
    return '1 minute Left';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds Left';
  } else {
    return 'Expired';
  }
}