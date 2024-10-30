import 'package:bookthief/components/position_picker.dart';
import 'package:bookthief/components/song_details.dart';
import 'package:bookthief/models/playlist_provider.dart';
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

  int hour = 0;
  int minute = 0;

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
          title: const Text("NOW PLAYING"),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_rounded,
                color: Theme.of(context).colorScheme.inversePrimary),
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
              const Spacer(),
              SongDetails(
                songName: value.currentSong.songName,
                artistName: value.currentSong.artistName,
              ),
              const Spacer(),
              Container(
                height: 300,
                width: 300,
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
                    boxShadow: kElevationToShadow[12]),
                child: Icon(
                  Icons.circle,
                  color: Theme.of(context).colorScheme.surface,
                  size: 200,
                ),
              ),
              const Spacer(),
              const Divider(
                indent: 30,
                endIndent: 30,
                // color: ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await value.togglePausePlay();
                      await HapticFeedback.lightImpact();
                    },
                    icon: Icon(
                      value.isPlaying
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_filled_outlined,
                      size: 40,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.timelapse_outlined,
                      size: 40,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.replay_outlined,
                      size: 40,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shuffle,
                      size: 40,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer()
              // const SizedBox(
              //   height: 30,
              // ),
              //   if (isPlaying)
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           width: 100,
              //           height: 100,
              //           alignment: Alignment.center,
              //           child: Text(
              //             hour.toString(),
              //             style: const TextStyle(
              //               fontSize: 48,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //         Container(
              //           alignment: Alignment.center,
              //           child: const Text(
              //             " : ",
              //             style: TextStyle(fontSize: 40),
              //           ),
              //         ),
              //         Container(
              //           width: 100,
              //           height: 100,
              //           alignment: Alignment.center,
              //           child: Text(
              //             minute.toString(),
              //             style: const TextStyle(
              //               fontSize: 48,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   if (!isPlaying)
              //     PositionPicker(
              //       hour: hour,
              //       minute: minute,
              //       onChangeHour: (value) => setState(() => hour = value),
              //       onChangeMin: (value) => setState(() => minute = value),
              //     ),
              //   const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
