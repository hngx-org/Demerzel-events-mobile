import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';

class HngTextInputField extends StatefulWidget {
  const HngTextInputField({
    Key? key,
    required this.onChanged,
    required this.validator,
    this.helperText = " ",
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.enabled = true,
    this.title,
    this.inputFormatters = const [],
    this.onEditingComplete,
  }) : super(key: key);

  final Function(String) onChanged;
  final FormFieldValidator<String> validator;
  final String? helperText;
  final String? hintText;
  final String? title;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;

  @override
  HngTextInputFieldState createState() => HngTextInputFieldState();
}

class HngTextInputFieldState extends State<HngTextInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.title != null)
        Text(widget.title ?? "", style: Theme.of(context).textTheme.bodyMedium),
      SizedBox(height: 8.h),
      TextFormField(
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          obscureText: widget.obscureText,
          obscuringCharacter: '●',
          style: widget.obscureText
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(letterSpacing: 4.w)
              : Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              fillColor: Theme.of(context).cardColor,
              filled: true,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ProjectColors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.error)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide: const BorderSide(color: ProjectColors.grey)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide: const BorderSide(color: ProjectColors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide: const BorderSide(color: ProjectColors.black)),
              helperStyle: const TextStyle(color: ProjectColors.black),
              helperText: widget.helperText))
    ]);
  }
}
