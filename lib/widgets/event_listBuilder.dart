

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
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () =>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentScreen(event: events[index]),
                ) ,),
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
                ref
                    .read(EventProvider.provider)
                    .deleteEvent(eventId)
                    .then((value) => {
                          if (value)
                            {
                              showSnackBar(context, 'Event deleted successfully',
                                  Colors.green),
                              ref.refresh(allEventsProviderOld),
                              ref.refresh(userEventsProvider),
                              ref.refresh(upcomingEventsProviderOld),
                              ref.read(GroupProvider.groupProvider).getGroups(),
                            }
                          else
                            {
                              showSnackBar(
                                  context,
                                  ref.read(EventProvider.provider).error,
                                  Colors.red),
                            }
                        });
              },
              showVert: ref.read(appUserProvider)?.id == events[index].creatorId,
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


 