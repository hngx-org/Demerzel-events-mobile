import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/features/events/create_event/create_event_screen.dart';
import 'package:hng_events_app/features/events/edit_event.dart';
import 'package:hng_events_app/util/snackbar_util.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';
import '../../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import '../../../riverpod/event_provider.dart';

class AllEventsScreen extends ConsumerWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screensize = MediaQuery.of(context).size;
    final eventNotifier = ref.watch(EventProvider.provider);
    final allEvents = ref.watch(allEventsProvider);

    return allEvents.when(
        skipLoadingOnRefresh: false,
        error: (error, stackTrace) {
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.refresh),
                  onPressed: () => ref.refresh(allEventsProvider)),
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
        data: (data) {
          return onData(context, ref, data, eventNotifier, screensize);
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
        });
  }

  Scaffold onData(BuildContext context, WidgetRef ref, List<Event> data,
      EventProvider eventNotifier, Size screensize) {
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
                onPressed: () => ref.refresh(allEventsProvider)),
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
      body: data.isEmpty
          ? const Center(
              child: Text('No Events'),
            )
          : ListView.builder(
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
                      onDelete: (eventId) {
                        eventNotifier.deleteEvent(eventId).then((value) => {
                              if (value)
                                {
                                  showSnackBar(
                                      context,
                                      'Event deleted successfully',
                                      Colors.green),
                                  ref.refresh(allEventsProvider),
                                  ref.refresh(userEventsProvider),
                                  ref.refresh(upcomingEventsProvider),
                                  ref
                                      .read(GroupProvider.groupProvider)
                                      .getGroups(),
                                }
                              else
                                {
                                  showSnackBar(
                                      context, eventNotifier.error, Colors.red),
                                }
                            });
                      },
                      showVert:
                          ref.read(appUserProvider)?.id == event.creatorId,
                      context: context,
                      screensize: screensize,
                      event: event),
                );
              },
            ),
    );
  }
}
