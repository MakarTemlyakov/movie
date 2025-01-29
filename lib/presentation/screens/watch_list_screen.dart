import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';
import 'package:moviedb/presentation/screens/movie_detail.dart';
import 'package:moviedb/presentation/widgets/bottom_nav_bar.dart';
import 'package:moviedb/presentation/widgets/movie_list_item.dart';
import 'package:moviedb/presentation/widgets/watch_list/empty_watch_list_widget.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late InAppWebViewController webViewController;
  final GlobalKey webViewKey = GlobalKey();
  String? requestToken;
  String url = "";
  List<Movie>? watchMovies;
  late bool isAuth;
  InAppWebViewSettings settings = InAppWebViewSettings(
    iframeAllowFullscreen: true,
  );

  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFetchData();
  }

  void setIsAuthStatus(bool isAuth) async {
    await MovieRepository().setIsAuthStatus(isAuth);
    this.isAuth = isAuth;
    setState(() {});
  }

  void initFetchData() async {
    requestToken = (await MovieRepository().getRequestToken())?.requestToken;
    if (requestToken != null) {
      watchMovies = await MovieRepository().getWatchListMovies();
    } else {
      requestToken =
          (await MovieRepository().createNewRequestToken()).requestToken;
    }
    isAuth = await MovieRepository().getIsAuth();
    setState(() {});
  }

  void getWatchListMovies() async {
    watchMovies = await MovieRepository().getWatchListMovies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Watch list",
          style: TextStyle(
            color: Color.fromRGBO(
              255,
              255,
              255,
              1,
            ),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/"),
            icon: Icon(Icons.arrow_back_ios),
            style: ButtonStyle(
              iconColor:
                  WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        screenIndex: 2,
      ),
      body: requestToken != null && !isAuth
          ? InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: WebUri(
                    "https://www.themoviedb.org/authenticate/${requestToken}"),
              ),
              initialSettings: settings,
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                this.url = url.toString();

                if (this.url.endsWith("allow")) {
                  getWatchListMovies();
                  setIsAuthStatus(true);
                  webViewController.dispose();
                } else {
                  setIsAuthStatus(false);
                }

                urlController.text = this.url;
                setState(() {});
              },
            )
          : watchMovies != null && watchMovies!.length > 0 && isAuth
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 44),
                  child: ListView.separated(
                    itemCount: watchMovies!.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 24,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/movie_detail",
                          arguments: MovieDetailScreenArguments(
                            id: watchMovies![index].id,
                          ),
                        ).whenComplete(getWatchListMovies),
                        child: MovieListItem(
                          watchMovie: watchMovies![index],
                        ),
                      );
                    },
                  ),
                )
              : EmptyWatchListWidget(),
    );
  }
}
