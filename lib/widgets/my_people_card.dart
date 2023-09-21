import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class MyPeopleCard extends StatelessWidget {
  const MyPeopleCard({
    super.key,
    required this.title,
    required this.image,
    required this.bubbleVisible,
  });

  final String title;
  final ImageProvider image;
  final bool bubbleVisible;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          
          decoration: BoxDecoration(
            color: ProjectColors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black, // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 0, // Blur radius
                offset: Offset(4, 5), // Offset in x and y directions
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10,),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: "NotoSans",
                  ),
                ),
              ),
              Center(
                child: Image(
                  image: image,
                  width: double.infinity,
                  height: 131,
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: bubbleVisible,
          child: Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
                  color: ProjectColors.purple,
                ),
                child: const Text(
                  "2 events",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              )),
        )
      ],
    );
  }
}