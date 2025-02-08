part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class OnChangedSearchEvent extends SearchEvent {
  final String? searchQuery;
  OnChangedSearchEvent({required this.searchQuery});
}
