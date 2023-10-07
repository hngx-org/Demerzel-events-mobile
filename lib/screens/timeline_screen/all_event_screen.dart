import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/my_events_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:hng_events_app/widgets/timeline_event_card.dart';

import '../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';

import '../../riverpod/event_provider.dart';

class AllEventsScreen extends ConsumerWidget {
  const AllEventsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screensize = MediaQuery.of(context).size;
    final eventNotifier = ref.watch(EventProvider.provider);
    final allEvents = ref.watch(allEventsProvider);

    return allEvents.when(
      skipLoadingOnRefresh: false,
       
      error: (error, stackTrace){
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.refresh),
              onPressed: ()=> ref.refresh(allEventsProvider)
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
        return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.refresh),
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
          body: data.data.events.isEmpty? const Center(child: Text('No Events'),) : 
              ListView.builder(
            itemCount: data.data.events.length,
            itemBuilder: (BuildContext context, int index) {
              final Event event = data.data.events[index];

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
      }, 
    );

    if (eventNotifier.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    if ((eventNotifier.allEvents?.data.events ?? []).isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No event was found", textAlign: TextAlign.center),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => eventNotifier.getAllEvent(),
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
      child: ListView.builder(
        itemCount: eventNotifier.allEvents?.data.events.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentScreen(
                    event: eventNotifier.allEvents!.data.events[index]),
              ),
            ),
            child: TimelineEventCard(
              context: context,
              screensize: screensize,
              image: eventNotifier.allEvents?.data.events[index].thumbnail,
              title: eventNotifier.allEvents?.data.events[index].title ?? "N/A",
              time: eventNotifier.allEvents?.data.events[index].startTime ??
                  "N/A",
              location:
                  eventNotifier.allEvents?.data.events[index].location ?? "N/A",
              date: eventNotifier.allEvents?.data.events[index].startDate ??
                  "N/A",
              activity: DateFormatter().timeLeft(
                  eventNotifier.allEvents!.data.events[index].startDate,
                  eventNotifier.allEvents!.data.events[index].startTime),
            ),
          );
        },
      ),
    );
  }

}

Widget eventCard(
    {required BuildContext context,
    required Size screensize,
    required String? image,
    required String title,
    required String time,
    required String location,
    required String date,
    required String activity}) {
  void _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0), // Adjust position as needed
      items: [
        PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
        PopupMenuItem<String>(value: 'edit', child: Text("edit"))
      ],
    ).then((String? value) {
      if (value == 'delete') {
        print('Delete item selected');
      }
    });
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    decoration: BoxDecoration(
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
      color: Theme.of(context).cardColor,
    ),
    child: SizedBox(
      height: 150.h,
      width: screensize.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Material(
                borderRadius: BorderRadius.circular(5),
                child: image == null
                    ? ColoredBox(
                        color: Colors.grey,
                        child: SizedBox.square(dimension: 100.r),
                      )
                    : Image.network(
                        image,
                        height: 90.r,
                        width: 90.r,
                        fit: BoxFit.fill,
                      ),
              )),
          Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(time,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    Expanded(
                        flex: 1,
                        child: Text(date,
                            style: TextStyle(
                                fontSize: 12.r, color: ProjectColors.grey))),
                    Expanded(
                        flex: 1,
                        child: Text(location,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.r))),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'delete') {
                        print('Delete item selected');
                      } else if (value == 'edit') {
                        print('Edit item selected');
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                    ],
                    child: const Icon(Icons.more_vert),
                  ),
                  Text(activity)
                ],
              )),
        ],
      ),
    ),
  );
}
