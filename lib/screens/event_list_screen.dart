import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/widgets/events_list.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ProjectColors.white,
        title: ListTile(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {},
          ),
          title: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Techies',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                Text('12 Members')
              ],
            ),
          ),
          trailing: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/img4.png'),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(),
                  color: ProjectColors.purple),
              child: const Center(
                child: Text(
                  "Today",
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView(
                shrinkWrap: true,
                children: const [
                  EventCard(),
                  EventCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



//events list widget
