import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:moviedb/presentation/screens/search_screen/bloc/search_screen_bloc_bloc.dart';
import 'package:moviedb/presentation/widgets/search_bar/bloc/bloc/search_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchUpdate) {
          if (ModalRoute.of(context)?.settings.name == AppRoutes.search) {
            BlocProvider.of<SearchScreenBlocBloc>(context)
                .add(OnLoadMovieDataEvent(searchQuery: state.searchQuery));
          }
          BlocProvider.of<HomeBloc>(context)
              .add(OnSearchMovies(searchQuery: state.searchQuery));
        }
      },
      builder: (context, state) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return TextField(
              controller: _searchController,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color.fromRGBO(103, 104, 109, 1)),
                filled: true,
                contentPadding: EdgeInsets.only(
                  left: 24,
                  top: 10,
                  bottom: 10,
                  right: 17,
                ),
                fillColor: Color.fromRGBO(58, 63, 71, 1),
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SearchBloc>().add(
                          OnChangedSearchEvent(
                            searchQuery: _searchController.text,
                          ),
                        );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(103, 104, 109, 1),
                  ),
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0))),
              ),
            );
          },
        );
      },
    );
  }
}
