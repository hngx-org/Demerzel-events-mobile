import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';

class HngSearchField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;

  const HngSearchField(
      {Key? key, required this.hintText, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45.h,
        child: TextFormField(
            keyboardType: TextInputType.text,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
                filled: true,
                fillColor: HngColors.primaryWhiteColor,
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: HngColors.hngGrey300,
                hintText: hintText,
                hintStyle: const TextStyle(color: HngColors.hngGrey300),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 5.w),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline)))));
  }
}
