import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class MyPeopleCard extends StatelessWidget {
  const MyPeopleCard({
    super.key,
    required this.title,
    required this.image,
    required this.bubbleVisible,
    required this.onPressed,
    required this.eventLength,
  });

  final String title;
  final String image;
  final bool bubbleVisible;
  final VoidCallback onPressed;
  final int eventLength;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(        
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "NotoSans",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: image == ''
                          ? Image.asset(
                              'assets/illustrations/dancers_illustration.png')
                          : Container(
                            height: 110,
                            width: 160,
                            
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: image,
                                  fit: BoxFit.fill,
                                ),
                            ),
                          ),
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
                      color: Theme.of(context).primaryColor,
                    ),
                    child:  Text(
                      "$eventLength events",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
