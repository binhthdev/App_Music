import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/constants/constants.dart';
import 'package:spotify_clone/widgets/artist_chip.dart';

import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart';
import '../bloc/search/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _SearchBox(),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 20),
                  child: Text(
                    "Recent searches",
                    style: TextStyle(
                      fontFamily: "AM",
                      fontWeight: FontWeight.w400,
                      color: MyColors.whiteColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.greenColor,
                        ),
                      );
                    } else if (state is SearchLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          return ArtistChip(
                              image: state.results[index].artistImage,
                              name: state.results[index].artistName,
                              radius: 23,
                              isDeletable: true);
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.error,
                          style: TextStyle(
                            fontFamily: "AM",
                            color: MyColors.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width - 102.5,
            decoration: const BoxDecoration(
              color: Color(0xff282828),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    "images/icon_search_transparent.png",
                    color: MyColors.whiteColor,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<SearchBloc>()
                            .add(SearchTextChanged(value));
                      },
                      style: TextStyle(
                        fontFamily: "AM",
                        fontSize: 16,
                        color: MyColors.whiteColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, left: 15),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontFamily: "AM",
                          color: MyColors.whiteColor,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                  fontFamily: "AM", color: MyColors.whiteColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
