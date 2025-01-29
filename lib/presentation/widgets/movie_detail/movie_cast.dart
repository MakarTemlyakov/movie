import 'package:flutter/material.dart';
import 'package:moviedb/domain/models/movie_cast.dart';

class MovieCastWidget extends StatelessWidget {
  final List<MovieCast> cast;
  const MovieCastWidget({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            left: 29,
            top: 36,
            right: 41,
            bottom: 21,
          ),
          sliver: SliverGrid.count(
            mainAxisSpacing: 24,
            crossAxisSpacing: 65,
            crossAxisCount: 2,
            children: [
              ...cast.map(
                (castItem) => MovieCastItem(
                  cast: castItem,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MovieCastItem extends StatelessWidget {
  final MovieCast cast;
  const MovieCastItem({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 8.0,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w200${cast.profilePath}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                cast.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
