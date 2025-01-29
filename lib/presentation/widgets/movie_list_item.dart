import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviedb/domain/models/rate_movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie watchMovie;
  const MovieListItem({super.key, required this.watchMovie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              width: 307,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${watchMovie.backdropPath ?? "/fx6c2UuNnXPwuRvu4tGaJJJITT6.jpg"}',
                      width: 95,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          watchMovie.title,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Wrap(
                                spacing: 4,
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    size: 18,
                                    color: Color.fromRGBO(255, 135, 0, 1),
                                  ),
                                  Text(
                                    watchMovie.voteAverage,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(255, 135, 0, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Wrap(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/ticket.svg',
                                      width: 16,
                                      height: 16,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Action',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 4,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 4,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/calendar.svg',
                                      width: 16,
                                      height: 16,
                                      colorFilter: ColorFilter.mode(
                                          Colors.white, BlendMode.srcATop),
                                    ),
                                    Text(
                                      watchMovie.releaseDate,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
