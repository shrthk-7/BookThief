import 'package:audioplayers/audioplayers.dart';
import 'package:bookthief/models/song.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  List<String> _paths = [];
  List<Song> _playlist = [];
  final AudioPlayer player = AudioPlayer();

  int _currentPlaying = 0;
  bool _isPLaying = false;

  List<Song> get playlist => _playlist;
  List<String> get paths => _paths;
  int get currentSongIndex => _currentPlaying;
  bool get isPlaying => _isPLaying;
  Song get currentSong => _playlist[_currentPlaying];

  setCurrentPlayingIndex(int songIndex) async {
    _currentPlaying = songIndex;
    await player.setSource(DeviceFileSource(_paths[songIndex]));
    notifyListeners();
  }

  togglePausePlay() async {
    if (_isPLaying) {
      await pauseSong();
    } else {
      await playSong();
    }
  }

  pauseSong() async {
    _isPLaying = false;
    await player.pause();
    notifyListeners();
  }

  playSong() async {
    _isPLaying = true;
    await player.resume();
    notifyListeners();
  }

  setPaths(List<String> paths) {
    _paths = paths;
    _playlist = paths
        .map(
          (path) => Song(
              songName: path.split("/").last,
              albumArtImagePath: "",
              artistName: path.split("/").last,
              audioPath: path),
        )
        .toList();
    notifyListeners();
  }

  addPath(String path) {
    if (_paths.contains(path)) return;
    _paths.add(path);
    setPaths(_paths);
  }
}
