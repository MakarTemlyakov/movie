part of 'watch_list_screen_bloc_bloc.dart';

@immutable
sealed class WatchListScreenBlocState {}

final class WatchListScreenBlocInitial extends WatchListScreenBlocState {}

final class WatchListState extends WatchListScreenBlocState {
  final String? requestToken;
  final List<Movie>? watchList;
  final bool isAuth;

  WatchListState({this.requestToken, this.watchList, this.isAuth = false});

  WatchListState copyWith({
    String? requestToken,
    List<Movie>? watchList,
    bool isAuth = false,
  }) {
    return WatchListState(
      watchList: watchList ?? this.watchList,
      requestToken: requestToken ?? this.requestToken,
      isAuth: isAuth,
    );
  }
}

final class WebViewState extends WatchListScreenBlocState {
  final URLRequest? urlRequest;
  final RequestToken? requestToken;
  final bool isAuth;
  final String url;

  WebViewState({
    this.urlRequest,
    this.requestToken,
    this.isAuth = false,
    this.url = "",
  });

  WebViewState copyWith({
    URLRequest? urlRequest,
    RequestToken? requestToken,
    bool isAuth = false,
    String? url,
  }) {
    return WebViewState(
      urlRequest: urlRequest ?? this.urlRequest,
      requestToken: requestToken ?? this.requestToken,
      isAuth: isAuth,
      url: url ?? this.url,
    );
  }
}
