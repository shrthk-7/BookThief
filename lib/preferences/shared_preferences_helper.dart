import 'dart:convert';
import 'package:bookthief/models/song.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileStorageHelper {
  static final FileStorageHelper _instance = FileStorageHelper._internal();
  static SharedPreferences? _preferences;

  final String AUDIO_FILE_PATHS = 'AUDIO_FILE_PATHS';

  FileStorageHelper._internal();

  factory FileStorageHelper() {
    return _instance;
  }

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> saveMusicFilesList(Map<String, Song> musicFiles) async {
    String json = jsonEncode(
      musicFiles.map((key, song) => MapEntry(key, song.toJson())),
    );
    await _preferences?.setString(AUDIO_FILE_PATHS, json);
  }

  Map<String, Song> getMusicFilesList() {
    String? json = _preferences?.getString(AUDIO_FILE_PATHS);
    if (json == null) return {};

    Map<String, dynamic> jsonMap = jsonDecode(json);
    Map<String, Song> decodedSongMap = jsonMap.map(
      (key, value) => MapEntry(key, Song.fromJson(value)),
    );

    print({'jsonList': decodedSongMap});
    return decodedSongMap;
  }

  Future<void> clearFile(String key) async {
    await _preferences?.remove(key);
  }
}
