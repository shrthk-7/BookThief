import 'package:flutter/material.dart';

class SongDetails extends StatelessWidget {
  final String songName;
  final String artistName;

  const SongDetails(
      {super.key, required this.songName, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.music_note_outlined,
                  size: 30,
                ),
              ),
              Flexible(
                child: Text(
                  songName,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.person_2_outlined,
              ),
            ),
            Flexible(
              child: Text(artistName.toUpperCase()),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ],
    );
  }
}
