import 'package:flutter/material.dart';
import 'package:hng_events_app/screens/timeline_screen/everyone_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/friends_screen.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:const Color(0xFFFFF8F5) ,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Friends",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Everyone",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )
            ],
          ),
        ),
        // ignore: prefer_const_constructors
        body: TabBarView(
          children: const [FriendsScreen(), EveryoneScreen()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffE78DFB),
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
