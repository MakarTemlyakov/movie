import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<OnLoadMoviesEvent>(_onloadMovieList);
    on<OnSearchMovies>(_onLoadSearchMovies);
  }

  Future<void> _onLoadSearchMovies(OnSearchMovies e, Emitter emit) async {
    if (e.searchQuery == "") {
      this.add(OnLoadMoviesEvent());
    } else {
      final searchMovies =
          await MovieRepository().getSearchMovies(e.searchQuery ?? "");
      emit(
        SearchMovies(searchMovies: searchMovies),
      );
    }
  }

  Future<void> _onloadMovieList(OnLoadMoviesEvent e, Emitter emit) async {
    final movieRepo = MovieRepository();
    final movieData = await Future.wait([
      movieRepo.getRateMovies(),
      movieRepo.getNowPlaying(),
      movieRepo.getPopular(),
      movieRepo.getUpcoming(),
      movieRepo.getTopRated()
    ]);

    emit(
      MoviesLoaded(
        trendMovies: movieData[0],
        nowPlayingdMovies: movieData[1],
        popularMovies: movieData[2],
        upComingMovies: movieData[3],
        topRatedMovies: movieData[4],
      ),
    );
  }
}
