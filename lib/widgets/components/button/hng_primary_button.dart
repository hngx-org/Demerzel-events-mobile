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
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            color: Colors.black
          )
        ]
      ),
      child: ElevatedButton(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              side: const BorderSide(
                width: 1,
                color: Colors.black
              ),
              fixedSize: Size(250, 50),
              // minimumSize: const Size(262, 52),
              padding: const EdgeInsets.all(0.0)),
          child:
    
          isLoading
              ? const SizedBox.square(
                dimension: 25,
                child: CircularProgressIndicator( color: Colors.white,))
              : Text(text,
                  style: const TextStyle(
                      color: ProjectColors.white
                    )
                  )
                    ),
    );
  }
}
