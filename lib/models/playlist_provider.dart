import 'package:audioplayers/audioplayers.dart';
import 'package:audiotags/audiotags.dart';
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
    if (songIndex == _currentPlaying) return;
    _currentPlaying = songIndex;
    _isPLaying = false;
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

  Future<Song> getSongFromPath(String path) async {
    Tag? tag = await AudioTags.read(path);
    return Song(
      songName: tag?.title ?? path.split('/').last,
      albumArtImagePath: "",
      artistName: tag?.trackArtist ?? "Unknown Artist",
      audioPath: path,
    );
  }

  setPaths(List<String> paths) async {
    _paths = paths;
    _playlist = [];
    for (final String path in paths) {
      _playlist.add(await getSongFromPath(path));
    }
    notifyListeners();
  }

  addPath(String path) async {
    if (_paths.contains(path)) return;
    _paths.add(path);
    _playlist.add(await getSongFromPath(path));
    notifyListeners();
  }
}
