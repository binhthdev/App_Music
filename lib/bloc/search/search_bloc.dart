import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:spotify_clone/data/datasource/artist_datasource.dart';
import 'package:spotify_clone/data/model/artist.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTextChanged>(_onSearchTextChanged);
  }

  Future<void> _onSearchTextChanged(
      SearchTextChanged event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final results = await search(event.searchText);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<List<Artist>> search(String query) async {
    log(query);
    final results =
        await ArtistLocalDatasource().getArtistList().then((artists) {
      log(artists.toString());
      return artists
          .where((artist) => artist.artistName.toLowerCase().contains(query))
          .toList();
    });
    return results;
  }
}
