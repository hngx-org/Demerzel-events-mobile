import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/classes/user.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/auth_provider.dart';
import 'package:hng_events_app/screens/dash_board_screen.dart';
import 'package:hng_events_app/screens/event_comment_screen.dart';
import 'package:hng_events_app/screens/screen_util.dart';
import 'package:hng_events_app/screens/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToSignIn(context);
  }

  void _navigateToSignIn(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => EventCommentScreen(eventid: 'eventid')),
        MaterialPageRoute(builder: (context) => ScreenUtilInitScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ProjectColors.bgColor,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child:
                    Image.asset('assets/illustrations/splash_screen_icon.png'),
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text('WetinDeySup',
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}