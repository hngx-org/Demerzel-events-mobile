import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/features/auth/auth_wrapper_screen.dart';
import 'package:hng_events_app/features/main/screen_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(_controller);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.7),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      _controller.forward();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50.0.h,
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Center(
                  child: Image.asset(
                      'assets/illustrations/splash_screen_icon.png'),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child:  Center(
                child: Text(
                  'WetinDeySup',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    
                  ),
                  textScaleFactor: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
