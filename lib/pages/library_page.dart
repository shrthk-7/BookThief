import 'dart:math';
import 'package:bookthief/models/playlist_provider.dart';
import 'package:bookthief/models/song.dart';
import 'package:bookthief/pages/song_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import "package:bookthief/components/my_drawer.dart";
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with WidgetsBindingObserver {
  late final PlaylistProvider playlistProvider;

  Future<void> _pickAndSaveAudioFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result == null) return;

    List<String> audioFilePaths =
        result.files.map((file) => file.path!).toList();

    for (final String path in audioFilePaths) {
      await playlistProvider.addSongFromPath(path);
    }
  }

  final List<Color> colors = const [
    Color(0xFF012a4a),
    Color(0xFF013a63),
    Color(0xFF01497c),
    Color(0xFF014f86),
    Color(0xFF2a6f97)
  ];

  List<Color> getRandomColors() {
    final random = Random();
    int index1 = random.nextInt(colors.length);
    int index2;

    do {
      index2 = random.nextInt(colors.length);
    } while (index2 == index1);

    return [colors[index1], colors[index2]];
  }

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await playlistProvider.storePlaylist();
    playlistProvider.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      await playlistProvider.storePlaylist();
      playlistProvider.dispose();
    }
  }

  void goToSong(String songKey) {
    playlistProvider.setCurrentPlayingIndex(songKey);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text("L I B R A R Y")),
      drawer: const MyDrawer(),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: _pickAndSaveAudioFiles,
          icon: const Icon(Icons.download_rounded),
          color: Colors.white,
        ),
      ),
      body: Selector<PlaylistProvider, Map<String, Song>>(
        selector: (context, value) => value.playlist,
        builder: (context, playlistValue, child) {
          final List<MapEntry<String, Song>> playlist =
              playlistValue.entries.toList();

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.8,
            ),
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              String key = playlist[index].key;
              Song song = playlist[index].value;

              return InkWell(
                onTap: () => goToSong(key),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: getRandomColors(),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          song.songName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 10,
                          right: 20,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          song.artistName,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
