import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/screens/dash_board_screen.dart';
import 'package:hng_events_app/navigation/navigation_manager.dart';

import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(370, 810),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFF97316),
                primary: HngColors.hngPurple,
                // secondary: const Color(0xFFF97316),
              ),
              useMaterial3: true,
            ),
            home: const DashBoardScreen(),
            onGenerateRoute: NavigationManager.generateRoute,
          );
        });
  }
}
