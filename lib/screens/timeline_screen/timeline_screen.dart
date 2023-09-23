import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/everyone_screen.dart';
import 'package:hng_events_app/widgets/app_header.dart';

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
        appBar: const AppHeader(title: 'Everyone', backButton: false),
        body: const EveryoneScreen(),
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
