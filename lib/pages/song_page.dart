import 'package:bookthief/components/my_drawer.dart';
import 'package:bookthief/components/neumorphic_box.dart';
import 'package:bookthief/models/playlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              value.currentSong.songName.toUpperCase().split('').join(' '),
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.menu_rounded),
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // album art
                Row(
                  children: [],
                ),

                // song progress
                Row(
                  children: [],
                ),

                // playback controls
                Row(
                  children: [],
                ),
              ],
            ),
          )),
    );
  }
}
