import 'package:flutter/material.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentStack extends StatelessWidget {
  const CommentStack(
      {super.key, required this.numberOfAvatars, this.firstComments});
  final int numberOfAvatars;
  final List? firstComments;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: (31.w * numberOfAvatars.toDouble()) + 5.w,
      child: Stack(
          children: List.generate(
        numberOfAvatars,
        (index) => Positioned(
          left: (29 * index).toDouble(),
          child: CircleAvatar(
            radius: 17.r,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 16.r,
              backgroundImage: NetworkImage(firstComments![index].avatar ?? ''),
            ),
          ),
        ),
      )),
    );
  }
}
