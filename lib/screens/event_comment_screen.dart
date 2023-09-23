import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/classes/event_comment.dart';
import 'package:hng_events_app/riverpod/event_comment_provider.dart';

class EventCommentScreen extends StatelessWidget {
  const EventCommentScreen({super.key, required this.eventid});
  final String eventid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const 
        Text('Event Comments'),
      ),
      body: Consumer(
        builder: (context, ref, child) {

          AsyncValue<List<EventComment>> eventComments = ref.watch(getEventCommentsProvider(eventid));

          return eventComments.when(
            error: (err, stackTrace)=> Text('error loading comments: $err'), 
            loading: ()=> const Center(child: CircularProgressIndicator(),),
            data: (data) {
              return ListView(
                children: List.generate(
                  data.length, 
                  (index) => ListTile(title: Text(data[index].comment),)
                ),
              );
            },
          );
        }
      ),
    );
  }
}