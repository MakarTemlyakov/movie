import 'package:flutter/material.dart';

import 'package:moviedb/domain/models/movie_review.dart';

class MovieReviews extends StatelessWidget {
  final List<MovieReview> reviews;
  const MovieReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 34, vertical: 18),
      child: ListView.separated(
        itemCount: reviews.length > 0 ? reviews.length : 0,
        itemBuilder: (context, index) {
          return MovieReviewItem(
            review: reviews[index],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 12,
        ),
      ),
    );
  }
}

class MovieReviewItem extends StatelessWidget {
  final MovieReview review;
  const MovieReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: review.authorDetails.avatarPath == ""
                  ? Image.asset(
                      "assets/images/no-avatar.png",
                      width: 44,
                      height: 44,
                    )
                  : Image.network(
                      'https://image.tmdb.org/t/p/w200${review.authorDetails.avatarPath}',
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              review.authorDetails.rating ?? "",
              style: TextStyle(color: Color.fromRGBO(2, 150, 229, 1)),
            ),
          ],
        ),
        SizedBox(
          width: 12,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.author,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                review.content,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
