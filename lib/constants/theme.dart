import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class ProjectTheme {

  static ThemeData materialTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ProjectColors.purple,
          primary:ProjectColors.purple,
          // secondary: const Color(0xFFF97316),
        ),
      textTheme: Theme.of(context).textTheme.apply(
        //fontSizeFactor: 1.2,
        fontSizeDelta: 2.0,
        fontFamily: 'NotoSans',
      ),
       useMaterial3: true,
    );
  }
  }