import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';
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
    final userEvents = ref.watch(userEventsProvider);

    return userEvents.when(
      skipLoadingOnRefresh: false,
      
      error: (error, stackTrace){
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: FloatingActionButton(
              shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.refresh),
                onPressed: ()=> ref.refresh(userEventsProvider)
            ),
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: Text('Failed to Retrieve Events', style: TextStyle(color: Colors.red),),
            ),
          ),
        );
      }, 
      loading: (){
        return const Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Please wait..'),
            ),
          ],
        ),);
      },
      data: (data){
        return onData(context, ref, data, eventNotifier, screensize);
      },  
    );

  }

  Scaffold onData(BuildContext context, WidgetRef ref, List<Event> data, EventProvider eventNotifier, Size screensize) {
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
              onPressed: ()=> ref.refresh(userEventsProvider)),
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
                onDelete: (eventId) {
                  eventNotifier.deleteEvent(eventId).then((value) => ref.refresh(userEventsProvider));
                },
                showVert: true,
                eventId: event.id,
                context: context, 
                screensize: screensize, 
                image: event.thumbnail, 
                title: event.title , 
                time: event.startTime ,
                location: event.location ,
                date: event.startDate ,
                activity: DateFormatter().timeLeft(event.startDate, event.startTime),
              ),
            );
          },
        ),
      );
  }
}
