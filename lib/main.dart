import 'package:flutter/material.dart';
import 'package:hng_events_app/screens/chat_screen.dart';
import 'package:hng_events_app/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WetinDeySup',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const ChatScreen(),
    );
    
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
                seedColor: const Color(0xffE78DFB),
                primary: ProjectColors.purple,
                // secondary: const Color(0xFFF97316),
              ),
              useMaterial3: true,
            ),
            home: const DashBoardScreen(),
            onGenerateRoute: NavigationManager.generateRoute,
          );
        });
      theme: ThemeData(primaryColor: ProjectColors.purple),
      home: const SplashScreen(),
      // home: const CreateGroup(),
    );
  }
}
