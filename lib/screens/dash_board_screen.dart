import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/settings.dart';
import 'package:hng_events_app/constants/theme/colors.dart';
import 'package:hng_events_app/constants/string.dart';
import 'package:hng_events_app/screens/calendar_screen.dart';
import 'package:hng_events_app/screens/my_people_screen.dart';
import 'package:hng_events_app/screens/timeline_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  static const List<Widget> _pages = <Widget>[
    TimelineScreen(),
    PeopleScreen(),
    CalendarScreen(),
    SettingsScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: _pages.elementAt(_currentIndex)),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: HngColors.hngGrey,
                      blurRadius: 10.0,
                      offset: Offset(0, 2)
                )
                ]),
            child: BottomNavigationBar(
                elevation: 0,
                onTap: (index) {
                  _currentIndex = index;
                  setState(() {});
                },
                backgroundColor: Colors.transparent,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedFontSize: 14,
                unselectedFontSize: 14,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.terminal, color: HngColors.hngGrey),
                      activeIcon:
                          Icon(Icons.terminal, color: HngColors.hngPurple),
                      label: HngString.timeLine),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people, color: HngColors.hngGrey),
                      activeIcon:
                          Icon(Icons.people, color: HngColors.hngPurple),
                      label: HngString.myPeople),
                  BottomNavigationBarItem(
                      icon:
                          Icon(Icons.calendar_month, color: HngColors.hngGrey),
                      activeIcon: Icon(Icons.calendar_month,
                          color: HngColors.hngPurple),
                      label: HngString.calendar),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings, color: HngColors.hngGrey),
                      activeIcon:
                          Icon(Icons.settings, color: HngColors.hngPurple),
                      label: HngString.settings),
                ])));
  }
}
