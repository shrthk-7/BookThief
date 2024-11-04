import 'package:audioplayers/audioplayers.dart';
import 'package:audiotags/audiotags.dart';
import 'package:bookthief/models/song.dart';
import 'package:bookthief/preferences/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  final FileStorageHelper storageHelper = FileStorageHelper();

  Map<String, Song> _playlist = {};
  String _currentPlayingKey = "";
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

    _playlist = storageHelper.getMusicFilesList();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Map<String, Song> get playlist => _playlist;
  bool get isPlaying => _isPLaying;
  Song? get currentSong => _playlist[_currentPlayingKey];
  double get currentProgress =>
      _position.inMilliseconds / _duration.inMilliseconds;
  Duration get position => _position;
  Duration get duration => _duration;

  setCurrentPlayingIndex(String newPlayingKey) async {
    if (newPlayingKey == _currentPlayingKey) return;
    if (!(_playlist.containsKey(newPlayingKey))) throw Error();
    updateLastPlayedPosition();

    Song song = _playlist[newPlayingKey]!;
    _currentPlayingKey = newPlayingKey;
    await _player.setSource(
      DeviceFileSource(song.audioPath),
    );
    await _player.seek(song.lastPlayedDuration);
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

  updateLastPlayedPosition() {
    if (!(_playlist.containsKey(_currentPlayingKey))) {
      return;
    }

    _playlist.update(_currentPlayingKey, (song) {
      song.setLastPlayedDuration(_position);
      return song;
    });
  }

  storePlaylist() async {
    await storageHelper.saveMusicFilesList(_playlist);
  }

  pauseSong() async {
    updateLastPlayedPosition();
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

  setSongs(Map<String, Song> songs) {
    _playlist = songs;
    _currentPlayingKey = "";
    _player.stop();
    notifyListeners();
  }

  addSong(Song song) async {
    if (_playlist.containsKey(song.audioPath)) return;
    _playlist[song.audioPath] = song;
    notifyListeners();
    await storePlaylist();
  }

  addSongFromPath(String path) async {
    if (_playlist.containsKey(path)) return;
    _playlist[path] = await getSongFromPath(path);
    notifyListeners();
    await storePlaylist();
  }
}
