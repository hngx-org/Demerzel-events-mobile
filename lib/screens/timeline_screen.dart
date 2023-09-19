import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/images.dart';
import 'package:hng_events_app/constants/routes.dart';
import 'package:hng_events_app/constants/string.dart';
import 'package:hng_events_app/widgets/components/button/hng_outline_button.dart';
import 'package:hng_events_app/widgets/components/text_input/hng_search_field.dart';
import 'package:hng_events_app/widgets/components/text_input/hng_text_field.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          HngSearchField(
            hintText: HngString.search,
            onChanged: (text) {},
          ),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(HngImages.homeImage),
          ),
          const Text(
            HngString.data,
            style: TextStyle(
              fontSize: 45,
              fontFamily: "Inter",
              fontWeight: FontWeight.w900,
            ),
          ),
          HngTextInputField(
            onChanged: (value) {},
            validator: (String? value) {},
          ),
          HngOutlineButton(
            text: HngString.goToFreeLunchPage,
            onPressed: () {
              Navigator.pushNamed(context, HngRoutes.home);
            },
          ),
        ],
      ),
    );
  }
}