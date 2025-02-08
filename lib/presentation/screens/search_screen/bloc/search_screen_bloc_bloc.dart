import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';

part 'search_screen_bloc_event.dart';
part 'search_screen_bloc_state.dart';

class SearchScreenBlocBloc
    extends Bloc<SearchScreenBlocEvent, SearchScreenBlocState> {
  SearchScreenBlocBloc() : super(SearchScreenBlocInitial(movies: [])) {
    on<OnLoadMovieDataEvent>(_onLoadMovieData);
  }

  Future<void> _onLoadMovieData(OnLoadMovieDataEvent e, Emitter emit) async {
    final searchMovies =
        await MovieRepository().getSearchMovies(e.searchQuery ?? "");
    emit(
      MovieListData(movies: searchMovies),
    );
  }
}
