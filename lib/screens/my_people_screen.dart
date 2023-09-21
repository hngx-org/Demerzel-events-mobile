import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';
import 'package:hng_events_app/widgets/my_people_header.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: const MyPeopleHeader(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: const [
            MyPeopleCard(
              title: "YBNL Mafia 🎶",
              image: AssetImage(
                "assets/illustrations/dancers_illustration.png",
              ),
              bubbleVisible: false,
            ),
            MyPeopleCard(
              title: "Techies 💻",
              image: AssetImage(
                "assets/illustrations/techies_illustration.png",
              ),
              bubbleVisible: true,
            ),
          ],
        ),
      ),
    );
  }
}
