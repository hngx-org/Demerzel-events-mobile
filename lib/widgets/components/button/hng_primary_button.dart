import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class HngPrimaryButton extends StatelessWidget {
  const HngPrimaryButton({
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
    return ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0.0,
            minimumSize: const Size(262, 52),
            padding: const EdgeInsets.all(0.0)),
        child:

        Container(
            constraints:
                const BoxConstraints(minWidth: 262.0, minHeight: 52.0),
            alignment: Alignment.center,
            child: isLoading
                ? const CircularProgressIndicator( color: Colors.white,)
                : Text(text,
                    style: const TextStyle(
                        color: ProjectColors.white
                      )
                    )
                  )
                  );
  }
}
