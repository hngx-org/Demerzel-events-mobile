import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/theme.dart';
import 'package:hng_events_app/screens/calendar_screen.dart';
import 'package:hng_events_app/screens/settings_screen.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ProjectTheme.materialTheme(context),
      home: const CalendarPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Title"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/img1.png"),
            ),
            Text(
              "data",
              style: TextStyle(
                  fontSize: 45,
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w900,
                  color: ProjectColors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}


// PULL TESTTTTTTTTTTTTT 