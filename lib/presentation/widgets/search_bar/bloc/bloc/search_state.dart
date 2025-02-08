part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {
  final String? searchQuery;
  SearchInitial({required this.searchQuery});
}

final class SearchUpdate extends SearchState {
  final String? searchQuery;
  SearchUpdate({required this.searchQuery});
}
