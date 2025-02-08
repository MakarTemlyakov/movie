import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(searchQuery: "")) {
    on<OnChangedSearchEvent>(_onChangedSerach);
  }

  void _onChangedSerach(OnChangedSearchEvent e, Emitter emmit) {
    emmit(SearchUpdate(searchQuery: e.searchQuery ?? ""));
  }
}
