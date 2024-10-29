import 'package:bookthief/models/song.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "FE!N",
      artistName: "Travis Scott",
      albumArtImagePath: "",
      audioPath: "assets/nokia.mp3",
    ),
    Song(
      songName: "Hallelujah",
      artistName: "Jeff Buckley",
      albumArtImagePath: "",
      audioPath: "assets/samsung.mp3",
    ),
    Song(
      songName: "Evergreen",
      artistName: "Ritcy Mitch & The Coal Miners",
      albumArtImagePath: "",
      audioPath: "assets/iphone.mp3",
    ),
    Song(
      songName: "Kafka on the Shore (Fiction) 2020",
      artistName: "Haruki Murakami",
      albumArtImagePath: "",
      audioPath: "assets/iphone.mp3",
    ),
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
