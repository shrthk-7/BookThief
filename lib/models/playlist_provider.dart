import 'package:audioplayers/audioplayers.dart';
import 'package:audiotags/audiotags.dart';
import 'package:bookthief/models/song.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Song> _playlist = [];
  final AudioPlayer _player = AudioPlayer();
  int _currentPlaying = -1;
  bool _isPLaying = false;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  PlaylistProvider() {
    _player.onDurationChanged.listen((duration) {
      _duration = duration;
      notifyListeners();
    });

    _player.onPositionChanged.listen((position) {
      _position = position;
      notifyListeners();
    });

    _player.onPlayerStateChanged.listen((playerState) {
      _isPLaying = playerState == PlayerState.playing;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  List<Song> get playlist => _playlist;
  int get currentSongIndex => _currentPlaying;
  bool get isPlaying => _isPLaying;
  Song get currentSong => _playlist[_currentPlaying];
  double get currentProgress =>
      _position.inMilliseconds / _duration.inMilliseconds;
  Duration get position => _position;
  Duration get duration => _duration;

  setCurrentPlayingIndex(int songIndex) async {
    if (songIndex == _currentPlaying) return;
    _currentPlaying = songIndex;
    await _player.setSource(
      DeviceFileSource(_playlist[_currentPlaying].audioPath),
    );
    notifyListeners();
  }

  togglePausePlay() async {
    if (_position == _duration) {
      _position = Duration.zero;
      _player.seek(Duration.zero);
    }

    if (_isPLaying) {
      await pauseSong();
    } else {
      await playSong();
    }
  }

  pauseSong() async {
    await _player.pause();
    notifyListeners();
  }

  playSong() async {
    await _player.resume();
    notifyListeners();
  }

  seekSong(int seconds) async {
    Duration newPosition = _position + Duration(seconds: seconds);
    if (newPosition >= _duration) {
      _isPLaying = false;
      await _player.pause();
      return await _player.seek(Duration.zero);
    }

    if (newPosition < Duration.zero) {
      return await _player.seek(Duration.zero);
    }

    await _player.seek(newPosition);
  }

  setProgress(double progress) async {
    Duration newPosition = Duration(
      milliseconds: (_duration.inMilliseconds * progress).toInt(),
    );
    _player.seek(newPosition);
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

  setSongs(List<Song> songs) {
    _playlist = songs;
    _currentPlaying = -1;
    _player.stop();
    notifyListeners();
  }

  addSong(Song song) {
    if (_playlist.any(
        (playlistSong) => playlistSong.audioPath == song.audioPath)) return;

    _playlist.add(song);
    notifyListeners();
  }

  addSongFromPath(String path) async {
    if (_playlist.any((playlistSong) => playlistSong.audioPath == path)) return;

    _playlist.add(await getSongFromPath(path));
    notifyListeners();
  }
}
