import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/features/auth/auth_wrapper_screen.dart';
import 'package:hng_events_app/features/splash/splash_screen.dart';
import 'package:hng_events_app/riverpod/theme_provider.dart';
import 'package:hng_events_app/features/main/dash_board_screen.dart';
import 'package:hng_events_app/features/navigation/navigation_manager.dart';

class ScreenUtilInitScreen extends ConsumerWidget {
  const ScreenUtilInitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(370, 810),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WetinDeySup',
            themeMode: ref.watch(themeProvider),
            darkTheme: ThemeData.dark(
              
              useMaterial3: true
            ).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: ProjectColors.purple,
                
              )
            ),

            theme: ThemeData(
              scaffoldBackgroundColor: ProjectColors.bgColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: ProjectColors.purple,
                primary: ProjectColors.purple,
                
                // secondary: const Color(0xFFF97316),
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
            onGenerateRoute: NavigationManager.generateRoute,
          );
        });
  }
}