import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/classes/user.dart';
import 'package:hng_events_app/riverpod/auth_provider.dart';
import 'package:hng_events_app/screens/signin_screen.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
          builder: (context, ref, child) {
            User? user = ref.watch(authProvider);
            return (user == null)? const SignIn() : const ScreenUtilInit() ;
          }
        );
  }
}