import 'package:flutter/material.dart';
import 'package:moviedb/domain/models/movie_cast.dart';
import 'package:moviedb/domain/models/movie_review.dart';
import 'package:moviedb/presentation/widgets/movie_detail/movie_cast.dart';
import 'package:moviedb/presentation/widgets/movie_detail/movie_description.dart';
import 'package:moviedb/presentation/widgets/movie_detail/movie_reviews.dart';
import 'package:moviedb/presentation/widgets/movie_detail/movie_tab.dart';

class MovieDetailTabBar extends StatelessWidget {
  final String about;
  final List<MovieReview>? reviews;
  final List<MovieCast> cast;
  const MovieDetailTabBar({
    super.key,
    required this.about,
    this.reviews,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    List<MovieTab> tabs = [
      MovieTab(
        name: "About Movie",
      ),
      MovieTab(
        name: "Reviews",
      ),
      MovieTab(
        name: "Cast",
      ),
    ];
    return Expanded(
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: true,
                  padding: EdgeInsets.only(left: 27),
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Color.fromRGBO(58, 63, 71, 1),
                  unselectedLabelColor: Color.fromRGBO(255, 255, 255, 1),
                  labelColor: Color.fromRGBO(255, 255, 255, 1),
                  labelStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  dividerHeight: 0,
                  controller: DefaultTabController.of(context),
                  tabs: tabs,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      MovieDescription(
                        desription: about,
                      ),
                      MovieReviews(
                        reviews: reviews ?? [],
                      ),
                      MovieCastWidget(
                        cast: cast,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
