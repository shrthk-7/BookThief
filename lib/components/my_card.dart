import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  const MyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
