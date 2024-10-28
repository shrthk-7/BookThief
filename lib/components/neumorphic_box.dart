import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.inversePrimary,
            blurRadius: 15,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
