import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/string.dart';
import 'package:hng_events_app/features/calendar/screens/calendar_screen.dart';
import 'package:hng_events_app/features/groups/my_people_screen.dart';


import 'package:hng_events_app/features/settings/settings_screens/settings_screen.dart';
import 'package:hng_events_app/features/events/timeline_screen/timeline_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  static const List<Widget> _pages = <Widget>[
    TimelineScreen(),
   MyPeopleScreen(),
    CalendarPage(),
    SettingsPage()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.only(top: 5.h, bottom: 8.h),
      decoration: BoxDecoration(
          border: const Border(top: BorderSide(width: 1)),
          color: Theme.of(context).cardColor,
          // borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: ProjectColors.grey,
                blurRadius: 3.0,
                offset: Offset(0, 2))
          ]),
      child: BottomNavigationBar(
        elevation: 0,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        // backgroundColor: Colors.transparent,
        fixedColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 14.sp,
        unselectedFontSize: 14.sp,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.timeline, color: ProjectColors.grey),
              activeIcon: Icon(Icons.timeline, color: Theme.of(context).colorScheme.primary),
              label: HngString.timeLine),
          BottomNavigationBarItem(
              icon: const Icon(Icons.groups_outlined, color: ProjectColors.grey),
              activeIcon:
                  Icon(Icons.groups_outlined, color: Theme.of(context).colorScheme.primary),
              label: HngString.myPeople),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month, color: ProjectColors.grey),
              activeIcon:
                  Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.primary),
              label: HngString.calendar),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings, color: ProjectColors.grey),
              activeIcon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
              label: HngString.settings),
        ],
      ),
    );
  }
}
