import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/features/events/edit_event/edit_event.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/util/snackbar_util.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';

class EvenListBuilder extends ConsumerWidget {
  const EvenListBuilder(
    this.events, {
    super.key,
  });
  final List<Event> events;
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentScreen(event: events[index]),
              ),
            ),
            child: TimelineEventCard(
              onEdit: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEventName(
                        currentEvent: events[index],
                      ),
                    ));
              },
              eventId: events[index].id,
              onDelete: (eventId) {
                showDialog(
                    context: ctx,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete event"),
                        content: const Text(
                            "Are you sure you want to delete this event?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              try {
                                Navigator.of(context).pop();
                                ref
                                    .read(EventProvider.provider)
                                    .deleteEvent(eventId)
                                    .then((value) {
                                  if (value) {
                                    ref.refresh(myEventsProvider);
                                    ref.refresh(allEventsProvider);
                                    ref.refresh(upcomingEventsProvider);
                                    ref.refresh(groupsProvider);
                                    ref.refresh(EventProvider.provider);
                                     //ref.read(GroupProvider.groupProvider).getGroups();
                                    showSnackBar(
                                        ctx,
                                        'Event deleted successfully',
                                        Colors.green);
                                    ref
                                        .read(GroupProvider.groupProvider)
                                        .getGroups();
                                  } else {
                                    showSnackBar(
                                        ctx,
                                        ref.read(EventProvider.provider).error,
                                        Colors.red);
                                  }
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Event could not be deleted ")));
                              }
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    });
              },
              showVert:
                  ref.read(appUserProvider)?.id == events[index].creatorId,
              context: context,
              screensize: MediaQuery.of(context).size,
              event: events[index],
            ),
          );
        },
        childCount: events.length,
      ),
    );
  }
}
