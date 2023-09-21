import 'package:flutter/material.dart';

class EveryoneScreen extends StatelessWidget {
  const EveryoneScreen({super.key});

  Widget bodyBuild(String title, String specifictime, String date,
      String location, String time) {
    return Container(
      height: 150,
      width: 400,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration:  BoxDecoration(
        color: const Color(0xFFFFFFFF),
        boxShadow:  const [
          BoxShadow(
            offset: Offset(4, 4),
            color: Color(0xff000000),
          ),
        ],
        borderRadius:  const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: const Color(0xff000000), width: 1),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/emoji.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                date,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(specifictime),
              const Spacer(),
              Text(
                location,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const Icon(Icons.more_vert),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                  color:Color(0xffE78DFB),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return bodyBuild('Football game', 'May 20,2023', 'Friday 4 - 6 PM',
                'Teslim Balogun Stadium', 'LIVE');
          } else{
            return  bodyBuild('Football game', 'May 20,2023', 'Friday 4 - 6 PM',
                'Teslim Balogun Stadium', 'In 2  Weeks');
          }
        });
  }
}