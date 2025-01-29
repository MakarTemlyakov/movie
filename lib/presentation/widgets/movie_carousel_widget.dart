import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:collection/collection.dart';
import 'package:moviedb/presentation/screens/movie_detail.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<Movie> rateMovies;
  MovieCarouselWidget({super.key, required this.rateMovies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 240,
        viewportFraction: 0.6,
        initialPage: 0,
      ),
      items: rateMovies.mapIndexed((index, rateMovie) {
        int incIndex = index + 1;
        return Builder(
          builder: (BuildContext context) {
            return MovieCarouselItemWidget(
              rateId: incIndex.toString(),
              rateMovie: rateMovie,
            );
          },
        );
      }).toList(),
    );
  }
}

class MovieCarouselItemWidget extends StatelessWidget {
  final Movie rateMovie;
  final String rateId;
  const MovieCarouselItemWidget(
      {super.key, required this.rateMovie, required this.rateId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/movie_detail",
          arguments: MovieDetailScreenArguments(id: rateMovie.id),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 30),
        child: SizedBox(
          width: 155,
          height: 240,
          child: Stack(clipBehavior: Clip.none, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${rateMovie.posterPath}",
                width: 200,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -20,
              left: -10,
              child: Text(
                rateId,
                style: TextStyle(
                  color: Color.fromRGBO(36, 42, 50, 1),
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0), // Смещение обводки
                      color: Color.fromRGBO(
                          2, 150, 229, 1), // Цвет обводки  // Размытие обводки
                    ),
                    Shadow(
                      offset: Offset(-1.0, -1.0),
                      color: Color.fromRGBO(2, 150, 229, 1),
                    ),
                    Shadow(
                      offset: Offset(1.0, -1.0),
                      color: Color.fromRGBO(2, 150, 229, 1),
                    ),
                    Shadow(
                      offset: Offset(-1.0, 1.0),
                      color: Color.fromRGBO(2, 150, 229, 1),
                    ),
                  ],
                  fontSize: 92,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
