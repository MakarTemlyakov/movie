import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviedb/domain/models/movie_detail.dart';

class ReferenceInfo extends StatelessWidget {
  final String releaseDate;
  final List<Genres?>? genres;
  final String timeDelation;
  const ReferenceInfo({
    super.key,
    required this.releaseDate,
    required this.timeDelation,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/calendar.svg',
            width: 16,
            height: 16,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            releaseDate,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(105, 105, 116, 1),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          VerticalDivider(
            width: 16.0,
            thickness: 1, // Увеличиваем толщину
            color: Color.fromRGBO(105, 105, 116, 1),
          ),
          SizedBox(
            width: 4,
          ),
          SvgPicture.asset(
            'assets/icons/clock.svg',
            width: 16,
            height: 16,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            timeDelation,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(105, 105, 116, 1)),
          ),
          SizedBox(
            width: 12,
          ),
          // Отступ между элементами
          VerticalDivider(
            width: 16.0,
            thickness: 1, // Увеличиваем толщину
            color: Color.fromRGBO(105, 105, 116, 1),
          ),
          SizedBox(
            width: 12,
          ),
          SvgPicture.asset(
            'assets/icons/ticket.svg',
            width: 16,
            height: 16,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            genres![0]!.name!,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(105, 105, 116, 1)),
          ),
        ],
      ),
    );
  }
}
