part of 'movie_detail_screen_bloc.dart';

@immutable
sealed class MovieDetailScreenEvent {}

final class OnLoadMovieDetailDataEvent extends MovieDetailScreenEvent {
  final int movieId;

  OnLoadMovieDetailDataEvent({required this.movieId});
}

final class OnAddMovieToWatchListEvent extends MovieDetailScreenEvent {}
