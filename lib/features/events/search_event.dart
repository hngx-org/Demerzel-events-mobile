import 'package:flutter/material.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';

class EventSearchDelegate extends SearchDelegate {
  final List<Event> events;
  EventSearchDelegate(
      {super.searchFieldLabel,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.events});

  @override
  String? get searchFieldLabel => '';

  @override
  TextStyle? get searchFieldStyle => const TextStyle();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    List<Event> list = events
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentScreen(event: list[index]))),
        child: TimelineEventCard(
          showVert: false,
          eventId: list[index].id,
          onDelete: (eventId) {
            // eventNotifier.deleteEvent(eventId).then((value) => ref.refresh(upcomingEventsProvider));
          },
          context: context,
          screensize: screensize,
        event: list[index],
          // activity: DateFormatter()
          //     .timeLeft(list[index].startDate, list[index].startTime),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    List<Event> list = events
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentScreen(event: list[index]))),
        child: TimelineEventCard(
          showVert: false,
          eventId: list[index].id,
          onDelete: (eventId) {
            // eventNotifier.deleteEvent(eventId).then((value) => ref.refresh(upcomingEventsProvider));
          },
          context: context,
          screensize: screensize,
         event: list[index]
        ),
      ),
    );
  }
}
