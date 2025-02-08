part of 'search_screen_bloc_bloc.dart';

@immutable
sealed class SearchScreenBlocEvent {}

class OnLoadMovieDataEvent extends SearchScreenBlocEvent {
  final String? searchQuery;
  OnLoadMovieDataEvent({required this.searchQuery});
}
