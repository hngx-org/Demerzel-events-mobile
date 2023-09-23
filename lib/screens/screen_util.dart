import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/classes/user.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/auth_provider.dart';
import 'package:hng_events_app/screens/dash_board_screen.dart';
import 'package:hng_events_app/navigation/navigation_manager.dart';
import 'package:hng_events_app/screens/signin_screen.dart';

class ScreenUtilInitScreen extends ConsumerWidget {
  const ScreenUtilInitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(authProvider);
    // return (user== null)? const SignIn() :ScreenUtilInit(
      return ScreenUtilInit(
        designSize: const Size(370, 810),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WetinDeySup',
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
  }
}