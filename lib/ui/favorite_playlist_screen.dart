import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/constants/constants.dart';

import '../bloc/favorite/favorite_playlist_cubit.dart';

class FavoritePlaylistScreen extends StatefulWidget {
  const FavoritePlaylistScreen({super.key});

  @override
  State<FavoritePlaylistScreen> createState() => _FavoritePlaylistScreenState();
}

class _FavoritePlaylistScreenState extends State<FavoritePlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<FavoritePlaylistCubit, FavoritePlaylistState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Favorite",
                      style: TextStyle(
                        fontFamily: "AM",
                        fontSize: 30,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.favoritePlaylists.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Image.asset(
                                "images/home/${state.favoritePlaylists[index]}",
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.favoritePlaylists[index],
                                    style: const TextStyle(
                                      fontFamily: "AM",
                                      fontSize: 17,
                                      color: MyColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Playlist",
                                    style:   TextStyle(
                                      fontFamily: "AM",
                                      fontSize: 14,
                                      color: MyColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<FavoritePlaylistCubit>()
                                  .removePlaylist(
                                      state.favoritePlaylists[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
