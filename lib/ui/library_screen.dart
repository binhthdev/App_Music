import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/constants.dart';
import 'package:spotify_clone/widgets/bottom_player.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Library",
                      style: TextStyle(
                        fontFamily: "AM",
                        fontSize: 30,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const OptionsList(),
                    const SizedBox(
                      height: 20,
                    ),
                    const _NewEpisodesSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                    const _LikedSongsSection(),
                     
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 64),
              child: BottomPlayer(),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewEpisodesSection extends StatelessWidget {
  const _NewEpisodesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset("images/new_episods.png"),
              Image.asset("images/icon_bell_fill.png"),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New Episods",
                style: TextStyle(
                  fontFamily: "AM",
                  fontSize: 15,
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Image.asset("images/icon_pin.png"),
                  const SizedBox(width: 5),
                  const Text(
                    "Updated 2 days ago",
                    style: TextStyle(
                      fontFamily: "AM",
                      color: MyColors.lightGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LikedSongsSection extends StatelessWidget {
  const _LikedSongsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset("images/liked_songs.png"),
              Image.asset("images/icon_heart_white.png"),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Liked Songs",
                style: TextStyle(
                  fontFamily: "AM",
                  fontSize: 15,
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Image.asset("images/icon_pin.png"),
                  const SizedBox(width: 5),
                  const Text(
                    "Playlist . 58 songs",
                    style: TextStyle(
                      fontFamily: "AM",
                      color: MyColors.lightGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LibraryOptionsChip extends StatelessWidget {
  const LibraryOptionsChip({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    List<String> chipTitle = [
      "Playlists",
      "Artists",
      "Albums",
      "Podcasts & shows"
    ];
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 33,
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.lightGrey,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  chipTitle[index],
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 12,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsList extends StatelessWidget {
  const OptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return LibraryOptionsChip(index: index);
        },
      ),
    );
  }
}