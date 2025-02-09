import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/domain/models/movie_cast.dart';
import 'package:moviedb/domain/models/movie_detail.dart';
import 'package:moviedb/domain/models/movie_review.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';

part 'movie_detail_screen_event.dart';
part 'movie_detail_screen_state.dart';

class MovieDetailScreenBloc
    extends Bloc<MovieDetailScreenEvent, MovieDetailScreenState> {
  final MovieRepository _movieRepository;
  MovieDetailScreenBloc(this._movieRepository)
      : super(MovieDetailScreenInitial()) {
    on<OnLoadMovieDetailDataEvent>(_onLoadData);
    on<OnAddMovieToWatchListEvent>(_addMovieToWatchList);
  }

  Future<void> _onLoadData(
      OnLoadMovieDetailDataEvent event, Emitter emit) async {
    final MovieDetail movie =
        await _movieRepository.getMovieDetail(event.movieId);
    final List<MovieReview> reviews =
        await _movieRepository.getReviewsByMovieId(event.movieId);
    final List<MovieCast> cast =
        await _movieRepository.getCastByMovieId(event.movieId);

    final bool isAddedToWatchList =
        AppLocal.movieWatchList.contains(event.movieId);

    emit(
      MovieDetailsState(
        movieId: event.movieId,
        cast: cast,
        reviews: reviews,
        movie: movie,
        isAddedToWatchList: isAddedToWatchList,
      ),
    );
  }

  Future<void> _addMovieToWatchList(
      OnAddMovieToWatchListEvent event, Emitter emit) async {
    final movieDetial = (state as MovieDetailsState);
    await _movieRepository.addMovieToWatchList(
        movieDetial.movieId, movieDetial.isAddedToWatchList);
    bool isAddedToWatchList =
        AppLocal.movieWatchList.contains(movieDetial.movieId);
    emit(
      movieDetial.copyWith(
        movieDetial.movieId,
        movieDetial.movie,
        movieDetial.reviews,
        movieDetial.cast,
        isAddedToWatchList,
      ),
    );
  }
}
