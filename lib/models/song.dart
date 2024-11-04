class Song {
  final String songName;
  final String artistName;
  final String albumArtImagePath;
  final String audioPath;
  final Duration lastPlayedDuration;

  Song({
    required this.songName,
    required this.artistName,
    required this.albumArtImagePath,
    required this.audioPath,
    this.lastPlayedDuration = Duration.zero,
  });

  Map<String, dynamic> toJson() => {
        'songName': songName,
        'artistName': artistName,
        'audioPath': audioPath,
        'albumArtImagePath': albumArtImagePath,
        'lastPlayedDuration': lastPlayedDuration.inMilliseconds,
      };

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        songName: json['songName'],
        artistName: json['artistName'],
        audioPath: json['audioPath'],
        albumArtImagePath: json['albumArtImagePath'],
        lastPlayedDuration: Duration(milliseconds: json['lastPlayedDuration']),
      );
}
