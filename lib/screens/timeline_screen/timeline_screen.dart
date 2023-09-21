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