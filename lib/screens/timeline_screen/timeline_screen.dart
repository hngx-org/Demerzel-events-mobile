import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/notifications_provider.dart';
import 'package:hng_events_app/screens/timeline_screen/all_event_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/My_events/my_events_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/upcoming_screen.dart';

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({super.key});

  @override
  ConsumerState<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends ConsumerState<TimelineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) return;

    //   if(_tabController.index == 0 && ref.read(EventProvider.provider).upcomingEvents.isEmpty) {
    //     ref.read(EventProvider.provider.notifier).getUpcomingEvent();
    //   }
    //   else if (_tabController.index == 1 &&
    //       ref.read(EventProvider.provider).userEvents.isEmpty) {
    //     ref.read(EventProvider.provider.notifier).getUserEvent();
    //   } else if (_tabController.index == 2 &&
    //       (ref.read(EventProvider.provider).allEvents?.data.events ?? [])
    //           .isEmpty) {
    //     ref.read(EventProvider.provider.notifier).getAllEvent();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(notificationProvider.notifier).getNotifications.call();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              const Tab(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                      // fontSize: 17,
                    ),
                  ),
                ),
              ),
              Tab(
                key: UniqueKey(),
                child: const Text(
                  "My Events",
                  style: TextStyle(
                    // fontSize: 17,
                    // color: Colors.black
                  ),
                ),
              ),
              Tab(
                key: UniqueKey(),
                child: const Text(
                  "All Events",
                  style: TextStyle(
                    // fontSize: 17,
                    // color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            const UpcomingEventScreen(),
            MyEventScreen(
              key: UniqueKey(),
            ),
            AllEventsScreen(
              key: UniqueKey(),
            ),
          ],
        ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: FloatingActionButton(
        //         shape: const CircleBorder(),
        //         backgroundColor: Theme.of(context).colorScheme.primary,
        //         child: Icon(Icons.refresh),
        //         onPressed: ()=> ref.refresh(upcomingEventsProvider)),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(bottom: 70.0),
        //       child: FloatingActionButton(
        //           backgroundColor: Theme.of(context).colorScheme.primary,
        //           shape: const CircleBorder(),
        //           onPressed: () {
        //             Navigator.push(context, MaterialPageRoute(builder: (context) {
        //               return const CreateEvents();
        //             }));
        //           },
        //           child: Container(
        //             height: 70.r,
        //             width: 70.r,
        //             decoration: BoxDecoration(
        //                 color: ProjectColors.purple,
        //                 borderRadius: BorderRadius.all(Radius.circular(50.r)),
        //                 // boxShadow: const [
        //                 //   BoxShadow(
        //                 //       color: ProjectColors.black,
        //                 //       spreadRadius: 3,
        //                 //       offset: Offset(0, 2)),
        //                 // ]
        //               ),
        //             child: const Icon(
        //               Icons.add,
        //               size: 40,
        //               color: Colors.black,
        //             ),
        //           )),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
