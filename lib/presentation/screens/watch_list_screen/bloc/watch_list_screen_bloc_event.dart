part of 'watch_list_screen_bloc_bloc.dart';

@immutable
sealed class WatchListScreenBlocEvent {}

final class OnChangeIsAuthStatus extends WatchListScreenBlocEvent {
  final bool isAuth;
  OnChangeIsAuthStatus({required this.isAuth});
}

final class OnLoadDataEvent extends WatchListScreenBlocEvent {}

final class OnCreateWebViewEvent extends WatchListScreenBlocEvent {}

final class OnLoadStartWebViewEvent extends WatchListScreenBlocEvent {
  final String? url;
  OnLoadStartWebViewEvent({required this.url});
}
