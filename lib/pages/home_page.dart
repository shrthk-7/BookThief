import "package:bookthief/components/my_drawer.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("B O O K T H I E F"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: const MyDrawer(),
    );
  }
}
