import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:moviedb/presentation/screens/movie_detail_screen/movie_detail.dart';
import 'package:moviedb/routing/app_routing.dart';
import 'package:moviedb/presentation/widgets/movie_carousel_widget.dart';
import 'package:moviedb/presentation/widgets/movie_list_item.dart';
import 'package:moviedb/presentation/widgets/search_bar/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late Widget homeBodyWidget = PreviewMovieList(
      tabController: _tabController,
      topRatedMovies: [],
      popularMovies: [],
      upComingMovies: [],
      nowPlayingdMovies: [],
    );
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          homeBodyWidget = PreviewMovieList(
            tabController: _tabController,
            topRatedMovies: state.topRatedMovies,
            popularMovies: state.popularMovies,
            upComingMovies: state.upComingMovies,
            nowPlayingdMovies: state.nowPlayingdMovies,
          );
        }

        if (state is SearchMovies) {
          homeBodyWidget = SearchMovieList(searchMovies: state.searchMovies);
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SearchBarWidget(),
              Flexible(
                child: homeBodyWidget,
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchMovieList extends StatelessWidget {
  final List<Movie> searchMovies;
  SearchMovieList({required this.searchMovies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return MovieListItem(
          watchMovie: searchMovies[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 15,
      ),
      itemCount: searchMovies.length,
    );
  }
}

class PreviewMovieList extends StatelessWidget {
  final TabController tabController;
  final List<Movie> topRatedMovies;
  final List<Movie> nowPlayingdMovies;
  final List<Movie> upComingMovies;
  final List<Movie> popularMovies;

  PreviewMovieList({
    required this.tabController,
    required this.topRatedMovies,
    required this.popularMovies,
    required this.upComingMovies,
    required this.nowPlayingdMovies,
  });

  @override
  Widget build(BuildContext context) {
    List<Tab> titleTabs = [
      AppLocalMovieTabs.nowPlaying,
      AppLocalMovieTabs.popular,
      AppLocalMovieTabs.topRated,
      AppLocalMovieTabs.popular
    ]
        .map((tabTitle) => Tab(
              text: tabTitle,
            ))
        .toList();
    return Column(
      children: [
        SizedBox(height: 20),
        MovieCarouselWidget(rateMovies: topRatedMovies),
        SizedBox(
          height: 20,
        ),
        Container(
          child: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            indicatorColor: Color.fromRGBO(58, 63, 71, 1),
            unselectedLabelColor: Color.fromRGBO(255, 255, 255, 1),
            labelColor: Color.fromRGBO(255, 255, 255, 1),
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            dividerHeight: 0,
            controller: tabController,
            tabs: titleTabs,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              BuilderMovies(movies: nowPlayingdMovies),
              BuilderMovies(movies: upComingMovies),
              BuilderMovies(movies: topRatedMovies),
              BuilderMovies(movies: popularMovies),
            ],
          ),
        ),
      ],
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
          onTap: () => router.go(
            AppRoutes.movieDetails,
            extra: MovieDetailScreenArguments(id: movies[index].id),
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
