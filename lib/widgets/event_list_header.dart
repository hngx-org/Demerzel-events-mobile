import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class EventListHeader extends StatelessWidget implements PreferredSizeWidget {
  const EventListHeader({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.white,
      padding: const EdgeInsets.only(bottom: 18, left: 10, right: 20,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 30,),
            onPressed: () {},
          ),
          const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
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
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/img4.png'),
          ),
        ],
      ),
    );
  }
}
