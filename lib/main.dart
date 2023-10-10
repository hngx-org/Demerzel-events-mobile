import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/theme_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(themeProvider.notifier).initCall.call();
    ref.read(appUserProvider.notifier).getUserInit.call();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WetinDeySup',
      themeMode: ref.watch(themeProvider),
        darkTheme: ThemeData.dark(
          
          useMaterial3: true
        ).copyWith(
          colorScheme: const ColorScheme.dark(
            
            primary: ProjectColors.purple
          )
        ), 

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ProjectColors.purple,
            primary: ProjectColors.purple,
            // secondary: const Color(0xFFF97316),
          ),
          useMaterial3: true,
        ),
      home: const SplashScreen(),
    );
  }
}
