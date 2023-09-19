import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';

class HngOutlineButton extends StatelessWidget {
  const HngOutlineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.h),),
          boxShadow: [
            BoxShadow(color: HngColors.primaryOrangeColor, spreadRadius: 1.r),
          ],        ),
        child: Padding(
            padding: const EdgeInsets.all(1.25),
            child: OutlinedButton(
                onPressed: isEnabled ? onPressed : null,
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    side: BorderSide.none,
                    minimumSize: const Size(262, 52),
                    padding: const EdgeInsets.all(0.0)),
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    constraints:
                        const BoxConstraints(minWidth: 262.0, minHeight: 52.0),
                    alignment: Alignment.center,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(text,
                            style: const TextStyle(
                                color: HngColors.primaryOrangeColor))))));
  }
}
