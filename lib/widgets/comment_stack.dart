import 'package:flutter/material.dart';

class CommentStack extends StatelessWidget {
  const CommentStack({super.key, required this.numberOfAvatars});
  final int numberOfAvatars;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: (31 * numberOfAvatars.toDouble()) + 5,
      child: Stack(
        children: List.generate(
            numberOfAvatars,
            (index) => Positioned(
                  left: switch (index) {
                    0 => 0,
                    _ => (29 * index).toDouble(),
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                    ),
                  ),
                )),
      ),
    );
  }
}
