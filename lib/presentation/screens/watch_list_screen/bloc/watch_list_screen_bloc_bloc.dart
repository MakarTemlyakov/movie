import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meta/meta.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/domain/models/request_token.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';

part 'watch_list_screen_bloc_event.dart';
part 'watch_list_screen_bloc_state.dart';

class WatchListScreenBlocBloc
    extends Bloc<WatchListScreenBlocEvent, WatchListScreenBlocState> {
  final MovieRepository _movieRepository;
  WatchListScreenBlocBloc(this._movieRepository)
      : super(WatchListScreenBlocInitial()) {
    on<OnChangeIsAuthStatus>(_onChangeAuthStatus);
    on<OnLoadDataEvent>(_onLoadData);
    on<OnCreateWebViewEvent>(_onCreateWebView);
    on<OnLoadStartWebViewEvent>(_onLoadStartWebView);
  }

  Future<void> _onChangeAuthStatus(
      OnChangeIsAuthStatus e, Emitter emmit) async {
    await _movieRepository.setIsAuthStatus(e.isAuth);
  }

  Future<void> _onLoadData(OnLoadDataEvent event, Emitter emmit) async {
    List<Movie>? watchMovies = [];
    RequestToken? requestToken = (await _movieRepository.getRequestToken());

    if (requestToken != null) {
      watchMovies = await _movieRepository.getWatchListMovies();
    } else {
      requestToken = (await _movieRepository.createNewRequestToken());
    }

    final bool isAuth = await _movieRepository.getIsAuth();

    emmit(
      WatchListState(
        watchList: watchMovies,
        requestToken: requestToken.requestToken,
        isAuth: isAuth,
      ),
    );
  }

  Future<void> _onCreateWebView(
      OnCreateWebViewEvent event, Emitter emmit) async {
    final requestToken = await _movieRepository.getRequestToken();
    final URLRequest urlRequest = URLRequest(
      url: WebUri("https://www.themoviedb.org/authenticate/${requestToken}"),
    );

    if (state is WebViewState) {
      emmit(
        (state as WebViewState).copyWith(
          requestToken: requestToken,
          urlRequest: urlRequest,
        ),
      );
    }
  }

  Future<void> _onLoadStartWebView(
      OnLoadStartWebViewEvent event, Emitter emmit) async {
    List<Movie>? watchMovies = [];
    bool isAuth = false;
    if (event.url!.endsWith("allow")) {
      watchMovies = await _movieRepository.getWatchListMovies();
      await _movieRepository.setIsAuthStatus(true);
      if (state is WatchListState) {
        emmit((state as WatchListState).copyWith(
          watchList: watchMovies,
        ));
      }
    } else {
      await _movieRepository.setIsAuthStatus(false);
    }
    isAuth = await _movieRepository.getIsAuth();

    if (state is WebViewState) {
      emmit(
        (state as WebViewState).copyWith(
          isAuth: isAuth,
          url: event.url!,
        ),
      );
    }
  }
}
