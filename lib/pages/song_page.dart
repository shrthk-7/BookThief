import 'package:bookthief/models/playlist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late final dynamic playlistProvider;
  dynamic isPlaying = true;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            "N O W  P L A Y I N G",
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.menu_rounded),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.pause_outlined,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                value.currentSong.songName.toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
              Text(value.currentSong.artistName),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_right_rounded,
                    size: 40,
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (selectedValue) async {
                        await HapticFeedback.selectionClick();
                      },
                      children: List.generate(
                        30,
                        (index) => Text(
                          '$index',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      looping: true,
                      squeeze: 1,
                      magnification: 1.2,
                    ),
                  ),
                  Text(
                    " : ",
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (selectedValue) async {
                        await HapticFeedback.selectionClick();
                      },
                      children: List.generate(
                        30,
                        (index) => Text(
                          '$index',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      looping: true,
                      squeeze: 1,
                      magnification: 1.2,
                    ),
                  ),
                ],
              )
              // Container(
              //   child: Icon(Icons.pause_outlined,
              //       color: Theme.of(context).colorScheme.inversePrimary,
              //       size: 100),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
