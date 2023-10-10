import 'package:flutter/material.dart';

class CommentStack extends StatelessWidget {
  const CommentStack(
      {super.key, required this.numberOfAvatars, this.firstComments});
  final int numberOfAvatars;
  final List? firstComments;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: (31 * numberOfAvatars.toDouble()) + 5,
      child: Stack(
          children: List.generate(
        numberOfAvatars,
        (index) => Positioned(
          left: (29 * index).toDouble(),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(firstComments![index].avatar ?? ''),
            ),
          ),
        ),
      )),
    );
  }
}
