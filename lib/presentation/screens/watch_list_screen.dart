import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Watch list",
            style: TextStyle(
                color: Color.fromRGBO(
                  255,
                  255,
                  255,
                  1,
                ),
                fontSize: 16,
                fontWeight: FontWeight.w500),
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 44),
          child: ListView.separated(
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(
              height: 24,
            ),
            itemBuilder: (context, index) {
              return Card(
                color: Colors.transparent,
                elevation: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/movie-2.png',
                      width: 95,
                      height: 120,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spiderman',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
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
                                  '2019',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Wrap(
                              spacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                  width: 16,
                                  height: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  '139 minutes',
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
              );
            },
          ),
        ));
  }
}
