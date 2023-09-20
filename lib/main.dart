import 'package:flutter/material.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF97316),
          primary: const Color(0xFFF97316),
          // secondary: const Color(0xFFF97316),
        ),
        useMaterial3: true,
      ),
      home: CreateEvents(),
      debugShowCheckedModeBanner: false,
      title: 'WetinDeySup',
      theme: ThemeData(primaryColor: ProjectColors.purple),
      home: const SplashScreen(),
    );
  }
}

