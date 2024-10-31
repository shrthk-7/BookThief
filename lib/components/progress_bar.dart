import 'package:flutter/material.dart';

class MyProgressBar extends StatelessWidget {
  double completion = 0;
  MyProgressBar({super.key, required this.completion});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            boxShadow: kElevationToShadow[8],
          ),
        ),
        SizedBox(
          width: 220,
          height: 220,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.inversePrimary,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            value: completion >= 0 && completion <= 1 ? completion : 0,
            strokeCap: StrokeCap.round,
          ),
        ),
      ],
    );
  }
}
