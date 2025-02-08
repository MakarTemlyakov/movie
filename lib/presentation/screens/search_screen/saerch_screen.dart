import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/presentation/screens/search_screen/bloc/search_screen_bloc_bloc.dart';
import 'package:moviedb/presentation/widgets/bottom_nav_bar.dart';
import 'package:moviedb/presentation/widgets/movie_list_item.dart';
import 'package:moviedb/presentation/widgets/search_bar/search_bar_widget.dart';
import 'package:moviedb/utils/get_capitalize-text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    late Widget searchScreenBody;
    return BlocBuilder<SearchScreenBlocBloc, SearchScreenBlocState>(
        builder: (context, state) {
      if (state is SearchScreenBlocInitial) {
        searchScreenBody = EmptySearchResult();
      }
      if (state is MovieListData) {
        searchScreenBody = state.movies.length > 0
            ? MovieListDataWidget(movies: state.movies)
            : EmptySearchResult();
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Search",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 15,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline),
                style: ButtonStyle(
                  iconColor:
                      WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ),
          ],
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
          screenIndex: 1,
        ),
        body: Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 29,
              right: 15,
              bottom: 16,
            ),
            child: Column(
              children: [
                SearchBarWidget(),
                SizedBox(
                  height: 24,
                ),
                Expanded(child: searchScreenBody),
              ],
            )),
      );
    });
  }
}

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 188,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/notfound_search.svg",
            width: 76,
            height: 76,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            textAlign: TextAlign.center,
            getCapitalizeText("We are sorry, we can not find the movie :("),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            textAlign: TextAlign.center,
            "Find your movie by Type title, categories, years, etc ",
            style: TextStyle(
              color: Color.fromRGBO(146, 146, 157, 1),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class MovieListDataWidget extends StatelessWidget {
  final List<Movie> movies;
  const MovieListDataWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MovieListItem(
          watchMovie: movies[index],
        );
      },
      itemCount: movies.length,
    );
  }
}
