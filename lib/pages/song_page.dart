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

  String formatTime(Duration position, Duration duration) {
    String format(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String hours = twoDigits(duration.inHours);
      String minutes = twoDigits(duration.inMinutes.remainder(60));
      String seconds = twoDigits(duration.inSeconds.remainder(60));

      return hours != "00" ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
    }

    return "${format(position)} / ${format(duration)}";
  }

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
      builder: (context, value, child) {
        return Scaffold(
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
                const Spacer(),
                SongDetails(
                  songName: value.currentSong?.songName ?? "Loading",
                  artistName: value.currentSong?.artistName ?? "Loading",
                ),
                const Spacer(),
                Slider(
                  value:
                      value.currentProgress.isNaN ? 0 : value.currentProgress,
                  min: 0,
                  max: 1,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  onChanged: value.setProgress,
                ),
                Text(formatTime(value.position, value.duration)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => value.seekSong(-10),
                      icon: Icon(
                        Icons.replay_10_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[4],
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.tertiary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await value.togglePausePlay();
                          await HapticFeedback.lightImpact();
                        },
                        icon: Icon(
                          value.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () => value.seekSong(10),
                      icon: Icon(
                        Icons.forward_10_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
                const Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
