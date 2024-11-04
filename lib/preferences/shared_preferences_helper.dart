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

  Future<void> saveMusicFilesList(List<Song> musicFiles) async {
    List<String> jsonList =
        musicFiles.map((file) => jsonEncode(file.toJson())).toList();
    print(jsonList);
    await _preferences?.setStringList(AUDIO_FILE_PATHS, jsonList);
  }

  List<Song> getMusicFilesList() {
    List<String>? jsonList = _preferences?.getStringList(AUDIO_FILE_PATHS);
    if (jsonList == null) return [];
    print({'jsonList': jsonList});
    return jsonList
        .map((jsonString) => Song.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  Future<void> clearFile(String key) async {
    await _preferences?.remove(key);
  }
}
