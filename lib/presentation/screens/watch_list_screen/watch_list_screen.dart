import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/presentation/screens/movie_detail_screen/movie_detail.dart';
import 'package:moviedb/presentation/screens/watch_list_screen/bloc/watch_list_screen_bloc_bloc.dart';
import 'package:moviedb/presentation/widgets/movie_list_item.dart';
import 'package:moviedb/presentation/widgets/watch_list/empty_watch_list_widget.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget widgetBody;
    return BlocBuilder<WatchListScreenBlocBloc, WatchListScreenBlocState>(
        builder: (context, state) {
      if (state is WebViewState) {
        if (state.requestToken != null && !state.isAuth) {
          widgetBody = WatchListWebView(
            url: state.url,
            urlRequest: state.urlRequest,
          );
        }
      }
      if (state is WatchListState) {
        if (state.watchList != null &&
            state.watchList!.length > 0 &&
            state.isAuth) {
          widgetBody = WatchMoviesList(watchMovies: state.watchList!);
        }
      } else {
        widgetBody = EmptyWatchListWidget();
      }
      return Container(
        child: widgetBody,
      );
    });
  }
}

class WatchListWebView extends StatelessWidget {
  final String url;
  final URLRequest? urlRequest;
  const WatchListWebView(
      {super.key, required this.url, required this.urlRequest});

  @override
  Widget build(BuildContext context) {
    final urlController = TextEditingController();
    late InAppWebViewController webViewController;
    final GlobalKey webViewKey = GlobalKey();
    InAppWebViewSettings settings = InAppWebViewSettings(
      iframeAllowFullscreen: true,
    );
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: urlRequest,
      initialSettings: settings,
      onWebViewCreated: (InAppWebViewController controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) {
        url = url;
        urlController.text = this.url;
        webViewController.dispose();
      },
    );
  }
}

class WatchMoviesList extends StatelessWidget {
  final List<Movie> watchMovies;
  const WatchMoviesList({super.key, required this.watchMovies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 44),
      child: ListView.separated(
        itemCount: watchMovies.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 24,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.movieDetails,
              arguments: MovieDetailScreenArguments(
                id: watchMovies[index].id,
              ),
            ).whenComplete(() =>
                BlocProvider.of<WatchListScreenBlocBloc>(context)
                  ..add(OnLoadDataEvent())),
            child: MovieListItem(
              watchMovie: watchMovies[index],
            ),
          );
        },
      ),
    );
  }
}
