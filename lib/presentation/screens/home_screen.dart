import 'package:flutter/material.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';
import 'package:moviedb/presentation/screens/movie_detail.dart';
import 'package:moviedb/presentation/widgets/bottom_nav_bar.dart';
import 'package:moviedb/presentation/widgets/movie_carousel_widget.dart';
import 'package:moviedb/presentation/widgets/movie_list_item.dart';
import 'package:moviedb/presentation/widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Movie> trendMovies = [];
  List<Movie> nowPlayingdMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upComingMovies = [];
  List<Movie> searchMovies = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _tabController = TabController(vsync: this, length: 4);
  }

  void onSearch(String searchValue) {
    fetchSearchMovies(searchValue);
    setState(() {});
  }

  void fetchSearchMovies(String searchValue) async {
    searchMovies = await MovieRepository().getSearchMovies(searchValue);
  }

  void fetchData() async {
    final movieData = await Future.wait([
      MovieRepository().getRateMovies(),
      MovieRepository().getNowPlaying(),
      MovieRepository().getPopular(),
      MovieRepository().getUpcoming(),
      MovieRepository().getTopRated()
    ]);

    trendMovies = movieData[0];
    nowPlayingdMovies = movieData[1];
    popularMovies = movieData[2];
    upComingMovies = movieData[3];
    topRatedMovies = movieData[4];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> titleTabs = ["Now playing", "Upcoming", "Top rated", "Popular"]
        .map((tabTitle) => Tab(
              text: tabTitle,
            ))
        .toList();
    Color bgTheme = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bgTheme,
      appBar: AppBar(
        backgroundColor: bgTheme,
        title: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: const Text(
            "What do you want to watch?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SearchBarWidget(
              onSearch: onSearch,
            ),
            Flexible(
              child: searchMovies.length == 0
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        MovieCarouselWidget(rateMovies: trendMovies),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TabBar(
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            indicatorColor: Color.fromRGBO(58, 63, 71, 1),
                            unselectedLabelColor:
                                Color.fromRGBO(255, 255, 255, 1),
                            labelColor: Color.fromRGBO(255, 255, 255, 1),
                            labelStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            dividerHeight: 0,
                            controller: _tabController,
                            tabs: titleTabs,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              BuilderMovies(movies: nowPlayingdMovies),
                              BuilderMovies(movies: upComingMovies),
                              BuilderMovies(movies: topRatedMovies),
                              BuilderMovies(movies: popularMovies),
                            ],
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return MovieListItem(
                          watchMovie: searchMovies[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: searchMovies.length,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        screenIndex: 0,
      ),
    );
  }
}

class BuilderMovies extends StatelessWidget {
  final List<Movie> movies;
  const BuilderMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14.0,
        crossAxisSpacing: 14.0,
        mainAxisExtent: 146,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            '/movie_detail',
            arguments: MovieDetailScreenArguments(id: movies[index].id),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500${movies[index].posterPath}",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
