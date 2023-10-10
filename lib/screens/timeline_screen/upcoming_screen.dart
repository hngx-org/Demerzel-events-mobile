import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import '../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import '../../riverpod/event_provider.dart';
import '../../widgets/timeline_event_card.dart';

class UpcomingEventScreen extends ConsumerStatefulWidget {
  const UpcomingEventScreen({super.key});

  @override
  ConsumerState<UpcomingEventScreen> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<UpcomingEventScreen> {

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
              // color: ProjectColors.black,
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
  Widget build(
    BuildContext context,
  ) {
    final eventNotifier = ref.watch(EventProvider.provider);
    Size screensize = MediaQuery.of(context).size;
    AsyncValue<List<Event>> events = ref.watch(upcomingEventsProvider);

    return events.when(
      skipLoadingOnRefresh: false,
      error: (error, stackTrace) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.refresh),
                onPressed: () => ref.refresh(upcomingEventsProvider)),
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: Text(
                'Failed to Retrieve Events',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        );
      },
      loading: () {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Please wait..'),
              ),
            ],
          ),
        );
      },
      data: (data){
        return onData(context, data, eventNotifier, screensize);
      }, 
    );

  }

  Scaffold onData(BuildContext context, List<Event> data, EventProvider eventNotifier, Size screensize) {
    return Scaffold(
        floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.refresh),
              onPressed: ()=> ref.refresh(upcomingEventsProvider)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CreateEvents();
                  }));
                },
                child: Container(
                  height: 70.r,
                  width: 70.r,
                  decoration: BoxDecoration(
                      color: ProjectColors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(50.r)),
                      // boxShadow: const [
                      //   BoxShadow(
                      //       color: ProjectColors.black,
                      //       spreadRadius: 3,
                      //       offset: Offset(0, 2)),
                      // ]
                    ),
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
        body: data.isEmpty? const Center(child: Text('No Events'),) : 
            ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            final Event event = data[index];

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentScreen(event: event),
                        ),
                      ),
                      child: TimelineEventCard(
                        showVert: false,
                        eventId: event.id,
                        context: context,
                        screensize: screensize,
                        image: event.thumbnail,
                        title: event.title,
                        time: event.startTime,
                        location: event.location,
                        date: event.startDate,
                        activity: DateFormatter()
                            .timeLeft(event.startDate, event.startTime),
                      ),
                    );
                  },
                ),
        );
      },
    );

    // if (eventNotifier.isBusy) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    // if (eventNotifier.upcomingEvents.isEmpty) {
    //   return Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         const Text("No event was found", textAlign: TextAlign.center),
    //         const SizedBox(height: 10),
    //         GestureDetector(
    //           onTap: () => eventNotifier.getAllEvent(),
    //           child: const Text(
    //             "Tap to Retry",
    //             style: TextStyle(decoration: TextDecoration.underline),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // return RefreshIndicator(
    //   onRefresh: () async => eventNotifier.getUpcomingEvent(),
    //   child: ListView.builder(
    //     itemCount: eventNotifier.upcomingEvents.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       final Event event = eventNotifier.upcomingEvents[index];

    //       return GestureDetector(
    //         onTap: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => CommentScreen(event: event),
    //           ),
    //         ),
    //         child: TimelineEventCard(
    //           context: context,
    //           screensize: screensize,
    //           image: event.thumbnail,
    //           title: event.title ,
    //           time: event.startTime ,
    //           location: event.location ,
    //           date: event.startDate ,
    //           activity: DateFormatter().timeLeft(event.startDate, event.startTime),
    //           onDelete: (eventId){
    //             eventNotifier.deleteEvent(eventId);
    //           },
    //           eventId: eventNotifier.allEvents!.data.events[index].id,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
