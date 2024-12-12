import 'package:flutter/material.dart';
import 'package:moviedb/presentation/screens/widgets/bottom_nav_bar.dart';
import 'package:moviedb/presentation/screens/widgets/movie_list_item.dart';

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
        bottomNavigationBar: BottomNavBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 44),
          child: ListView.separated(
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(
              height: 24,
            ),
            itemBuilder: (context, index) {
              return MovieListItem();
            },
          ),
        ));
  }
}
