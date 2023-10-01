import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/all_event_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/my_events_screen.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F5),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              // Tab(
              //   child: Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text(
              //       "Upcoming Events",
              //       style: TextStyle(fontSize: 17, color: Colors.black),
              //     ),
              //   ),
              // ),
              Tab(
                key: UniqueKey(),
                child: const Text(
                  "My Events",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              Tab(
                key: UniqueKey(),
                child: const Text(
                  "All Events",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // UpcomingEventScreen(),
            MyEventScreen(
              key: UniqueKey(),
            ),
            AllEventsScreen(
              key: UniqueKey(),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: FloatingActionButton(
              backgroundColor: ProjectColors.purple,
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
                    boxShadow: const [
                      BoxShadow(
                          color: ProjectColors.black,
                          spreadRadius: 3,
                          offset: Offset(0, 2)),
                    ]),
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.black,
                ),
              )),
        ),
      ),
    );
  }
}
