part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class OnLoadMoviesEvent extends HomeEvent {}

class OnSearchMovies extends HomeEvent {
  final String? searchQuery;
  OnSearchMovies({required this.searchQuery});
}
