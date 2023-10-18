// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/features/events/create_event/create_event_screen.dart';
import 'package:hng_events_app/features/events/edit_event.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';
import '../../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import '../../../riverpod/event_provider.dart';

class MyEventScreen extends ConsumerStatefulWidget {
  const MyEventScreen({Key? key}) : super(key: key);

  @override
  _MyEventScreenState createState() => _MyEventScreenState();
}

class _MyEventScreenState extends ConsumerState<MyEventScreen> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    final eventNotifier = ref.watch(EventProvider.provider);
    final userEvents = ref.watch(userEventsProvider);

    return userEvents.when(
      skipLoadingOnRefresh: false,
      error: (error, stackTrace) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.refresh),
                onPressed: () => ref.refresh(userEventsProvider)),
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
      data: (data) {
        return Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Tooltip(
                      message: 'Refresh',
                      child: Icon(Icons.refresh),
                    ),
                    onPressed: () => ref.refresh(userEventsProvider)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                      child: const Tooltip(
                        message: "Add Event",
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          body: data.isEmpty
              ? const Center(
                  child: Text('No Events'),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    final Event event = data[index];

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentScreen(event: event),
                        ),
                      ),
                      child: TimelineEventCard(
                         showVert: ref.read(appUserProvider)?.id == event.creatorId,
                          onDelete: (eventId) {
                            showDialog(
                                context: ctx,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Confirm Delete"),
                                    content: const Text(
                                        "Are you sure you want to delete?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(ctx).pop();

                                          final result = await eventNotifier
                                              .deleteEvent(eventId);

                                          if (result) {
                                            ref.refresh(userEventsProvider);
                                            ref.refresh(allEventsProvider);
                                            ref.refresh(upcomingEventsProvider);
                                            ref
                                                .read(
                                                    GroupProvider.groupProvider)
                                                .getGroups();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    "Event deleted successfully"),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        eventNotifier.error)));
                                          }
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      )
                                    ],
                                  );
                                });
                          },
                          onEdit: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEventName(
                                    currentEvent: event,
                                  ),
                                ));
                          },
                          eventId: event.id,
                          context: context,
                          screensize: screensize,
                          event: event),
                    );
                  },
                ),
        );
      },
    );


  }
}
