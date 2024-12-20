import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviedb/presentation/screens/widgets/movie_detail/movie_detail_tab_bar.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark),
              style: ButtonStyle(
                iconColor:
                    WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          )
        ],
        title: Text(
          "Detail",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
            style: ButtonStyle(
              iconColor:
                  WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 270,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/bg.png",
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: 210,
                ),
                Positioned(
                  bottom: 70,
                  right: 11,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(37, 40, 54, 32),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Wrap(
                      spacing: 4,
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 16,
                          color: Color.fromRGBO(255, 135, 0, 1),
                        ),
                        Text(
                          '9.5',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 135, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/spider-man.png"),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Spiderman No Way Home",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
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
                  "2021",
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
                  "148 Minutes",
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
                  "Action",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(105, 105, 116, 1)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          MovieDetailTabBar(),
        ],
      ),
    );
  }
}
