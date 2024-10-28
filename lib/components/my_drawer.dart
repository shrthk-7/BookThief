import 'package:bookthief/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
            child: Icon(Icons.book_rounded,
                size: 40, color: Theme.of(context).colorScheme.inversePrimary),
          )),
          Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                title: const Text("TOGGLE THEME"),
                leading: const Icon(Icons.color_lens_rounded),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              )),
        ],
      ),
    );
  }
}
