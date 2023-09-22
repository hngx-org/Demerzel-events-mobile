// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hng_events_app/constants/images.dart';
// import 'package:hng_events_app/constants/string.dart';
// import 'package:hng_events_app/widgets/components/button/hng_outline_button.dart';
// import 'package:hng_events_app/widgets/components/text_input/hng_search_field.dart';
// import 'package:hng_events_app/widgets/components/text_input/hng_text_field.dart';

// class TimelineScreen extends StatefulWidget {
//   const TimelineScreen({super.key});

//   @override
//   State<TimelineScreen> createState() => _TimelineScreenState();
// }

// class _TimelineScreenState extends State<TimelineScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.h),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 10.h,
//           ),
//           HngSearchField(
//             hintText: HngString.search,
//             onChanged: (text) {},
//           ),
//           const CircleAvatar(
//             radius: 50,
//             backgroundImage: AssetImage(ProjectImages.homeImage),
//           ),
//           const Text(
//             HngString.data,
//             style: TextStyle(
//               fontSize: 45,
//               fontFamily: "Inter",
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//           HngTextInputField(
//             onChanged: (value) {},
//             validator: (String? value) {
//               return null; //replace with logic code for the validator
//             },
//           ),
//           HngOutlineButton(
//             text: HngString.goToFreeLunchPage,
//             onPressed: () {
//               // Navigator.pushNamed(context, HngRoutes.home);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/everyone_screen.dart';
import 'package:hng_events_app/screens/timeline_screen/friends_screen.dart';

import '../../constants/string.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F5),
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor: ProjectColors.grey,
            tabs: [
              Tab(
                child: Text(
                  HngString.friends,
                  style: TextStyle(
                      fontSize: 20,
                      color: _tabController.index == 0
                          ? ProjectColors.black
                          : ProjectColors.grey),
                ),
              ),
              Tab(
                child: Text(
                  HngString.everyOne,
                  style: TextStyle(
                      fontSize: 20,
                      color: _tabController.index == 1
                          ? ProjectColors.black
                          : ProjectColors.grey),
                ),
              ),
            ],
          ),
        ),
        // ignore: prefer_const_constructors
        body: TabBarView(
          controller: _tabController,
          children: const [FriendsScreen(), EveryoneScreen()],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: FloatingActionButton(
              backgroundColor: ProjectColors.purple,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateEvents();
                }));
              },
              child: Container(
                height: 70.r,
                width: 70.r,
                decoration: BoxDecoration(
                    color: ProjectColors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                    boxShadow: [
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
