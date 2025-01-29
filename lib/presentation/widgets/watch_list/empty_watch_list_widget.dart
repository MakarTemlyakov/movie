import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWatchListWidget extends StatelessWidget {
  const EmptyWatchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/box.svg",
            width: 76,
            height: 76,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "There is no movie yet!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Find your movie by Type title, categories, years, etc",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(146, 146, 157, 1),
            ),
          )
        ],
      ),
    );
  }
}
