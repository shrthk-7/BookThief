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
                    fontWeight: FontWeight.w900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.person_2_outlined,
                color: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withOpacity(0.7),
              ),
            ),
            Flexible(
              child: Text(
                artistName.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
