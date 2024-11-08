import 'package:spotify_clone/data/model/artist.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Artist> results;

  SearchLoaded(this.results);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}