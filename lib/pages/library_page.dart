import 'package:bookthief/models/playlist_provider.dart';
import 'package:bookthief/models/song.dart';
import 'package:bookthief/pages/song_page.dart';
import 'package:flutter/material.dart';

import "package:bookthief/components/my_drawer.dart";
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(title: const Text("L I B R A R Y")),
        drawer: const MyDrawer(),
        body: Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            final List<Song> playlist = value.playlist;
            return ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final Song song = playlist[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: ListTile(
                      title: Text(song.songName),
                      subtitle: Text(song.artistName),
                      onTap: () => goToSong(index),
                      leading: const Icon(
                        Icons.library_music_rounded,
                        size: 40,
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
