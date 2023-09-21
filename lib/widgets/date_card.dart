import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 60,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(),
          color: ProjectColors.purple),
      child: const Center(
        child: Text(
          "Today",
        ),
      ),
    );
  }
}