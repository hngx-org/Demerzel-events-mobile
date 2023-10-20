import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';

class EventSearchDelegate extends SearchDelegate {
  EventSearchDelegate(
      {super.searchFieldLabel,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,});

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
    
    return Consumer(
      builder: (context, ref, child) {
        final searchProvider = ref.watch(eventSearchProvider(query));

        return searchProvider.when(
          skipLoadingOnRefresh: false,
          data: (data){
            List<Event> list = query.isEmpty? [] : data;
            return OnDataWidget(list: list, screensize: screensize);
          }, 
          error: (error, stackTrace){
            return const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: Text(
                'Failed to Retrieve Events',
                style: TextStyle(color: Colors.red),
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
          }
        );
        
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final searchProvider = ref.watch(eventSearchProvider(query));

        return searchProvider.when(
          skipLoadingOnRefresh: false,
          data: (data){
            List<Event> list = query.isEmpty? [] : data;
            return OnDataWidget(list: list, screensize: screensize);
          }, 
          error: (error, stackTrace){
            return const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: Text(
                'Failed to Retrieve Events',
                style: TextStyle(color: Colors.red),
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
          }
        );
        
      }
    );
  }
}

class OnDataWidget extends StatelessWidget {
  const OnDataWidget({
    super.key,
    required this.list,
    required this.screensize,
  });

  final List<Event> list;
  final Size screensize;

  @override
  Widget build(BuildContext context) {
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
}
