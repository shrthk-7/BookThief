import 'package:bookthief/models/song.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  List<String> _paths = [];
  List<Song> _playlist = [];

  int _currentPlaying = 0;
  bool _isPLaying = false;

  List<Song> get playlist => _playlist;
  List<String> get paths => _paths;
  int get currentSongIndex => _currentPlaying;
  bool get isPlaying => _isPLaying;
  Song get currentSong => _playlist[_currentPlaying];

  set currentSongIndex(int songIndex) {
    _currentPlaying = songIndex;
    notifyListeners();
  }

  pauseSong() {
    _isPLaying = false;
    notifyListeners();
  }

  playSong() {
    _isPLaying = true;
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
