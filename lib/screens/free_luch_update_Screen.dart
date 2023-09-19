import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/images.dart';
import '../constants/routes.dart';
import '../constants/string.dart';
import '../widgets/components/button/hng_primary_button.dart';
import '../widgets/components/text_input/hng_search_field.dart';

class FreeLunchUpdateScreen extends StatefulWidget {
  const FreeLunchUpdateScreen({super.key});

  @override
  State<FreeLunchUpdateScreen> createState() => _FreeLunchUpdateScreenState();
}

class _FreeLunchUpdateScreenState extends State<FreeLunchUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(HngString.goToFreeLunchPage),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            HngPrimaryButton(
              text: HngString.goToHomePage,
              onPressed: () {
                Navigator.pushNamed(context, HngRoutes.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
