import 'package:bookthief/models/song.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Nokia",
        artistName: "Nokia",
        albumArtImagePath: "",
        audioPath: "assets/nokia.mp3"),
    Song(
        songName: "Samsung",
        artistName: "Samsung",
        albumArtImagePath: "",
        audioPath: "assets/samsung.mp3"),
    Song(
        songName: "Iphone",
        artistName: "Iphone",
        albumArtImagePath: "",
        audioPath: "assets/iphone.mp3"),
  ];

  int _currentPlaying = 0;

  List<Song> get playlist => _playlist;
  int get currentSongIndex => _currentPlaying;
  Song get currentSong => _playlist[_currentPlaying];

  set currentSongIndex(int songIndex) {
    _currentPlaying = songIndex;
    notifyListeners();
  }
}
