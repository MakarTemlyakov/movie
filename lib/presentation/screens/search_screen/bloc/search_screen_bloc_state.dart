part of 'search_screen_bloc_bloc.dart';

@immutable
sealed class SearchScreenBlocState {}

final class SearchScreenBlocInitial extends SearchScreenBlocState {
  final List<Movie> movies;
  SearchScreenBlocInitial({required this.movies});
}

final class MovieListData extends SearchScreenBlocState {
  final List<Movie> movies;
  MovieListData({required this.movies});
}
