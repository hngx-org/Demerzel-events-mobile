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

class AllEventsScreen extends ConsumerWidget {
  const AllEventsScreen({super.key});

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
              color: ProjectColors.black,
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
                      fit: BoxFit.fill,
                      width: 100.r,
                      height: 100.r,
                    ),
                    child: Image.asset(
                      'assets/images/emoji.png',
                      fit: BoxFit.cover,
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
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.h)),
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
      data: (data){
        return onData(context, ref, data, eventNotifier, screensize);
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
      }
    );

  }

  Scaffold onData(BuildContext context, WidgetRef ref, GetListEventModel data, EventProvider eventNotifier, Size screensize) {
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
                onEdit: (eventId) {
                  
                },
                eventId: event.id,
                onDelete: (eventId) {
                  eventNotifier.deleteEvent(eventId).then((value) => ref.refresh(allEventsProvider));
                },
                context: context, 
                screensize: screensize, 
                image: event.thumbnail, 
                title: event.title , 
                time: event.startTime ,
                location: event.location ,
                date: event.startDate ,
                activity: DateFormatter().timeLeft(event.startDate, event.startTime), showVert: false,
              ),
            );
          },
        ),
      );
  }

  static String timeLeft(DateTime date) {
    final date2 = DateTime.now();
    final difference = date.difference(date2);

    if ((difference.inDays / 7).floor() >= 1) {
      return '1 week Left';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days Left';
    } else if (difference.inDays >= 1) {
      return '1 day Left';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours Left';
    } else if (difference.inHours >= 1) {
      return '1 hour Left';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes Left';
    } else if (difference.inMinutes >= 1) {
      return '1 minute Left';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds Left';
    } else {
      return 'Expired';
    }
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
    required String activity,
    required Function onDelete}) {
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
                        onDelete();
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
