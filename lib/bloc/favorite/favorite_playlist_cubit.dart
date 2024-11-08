import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// State of the Cubit
class FavoritePlaylistState extends Equatable {
  final List<String> favoritePlaylists;

  const FavoritePlaylistState({this.favoritePlaylists = const []});

  @override
  List<Object> get props => [favoritePlaylists];
}

// Cubit to manage the state
class FavoritePlaylistCubit extends Cubit<FavoritePlaylistState> {
  FavoritePlaylistCubit() : super(const FavoritePlaylistState());

  void addPlaylist(String playlist) {
    final updatedPlaylists = List<String>.from(state.favoritePlaylists)..add(playlist);
    emit(FavoritePlaylistState(favoritePlaylists: updatedPlaylists));
  }

  void removePlaylist(String playlist) {
    final updatedPlaylists = List<String>.from(state.favoritePlaylists)..remove(playlist);
    emit(FavoritePlaylistState(favoritePlaylists: updatedPlaylists));
  }
}