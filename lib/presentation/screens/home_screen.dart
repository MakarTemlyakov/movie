import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moviedb/presentation/screens/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    Color bgTheme = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bgTheme,
      appBar: AppBar(
        backgroundColor: bgTheme,
        title: const Text(
          "What do you want to watch?",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 42.0,
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Color.fromRGBO(103, 104, 109, 1)),
                  filled: true,
                  fillColor: Color.fromRGBO(58, 63, 71, 1),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(103, 104, 109, 1),
                  ),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 240,
                viewportFraction: 0.5,
                initialPage: 0,
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(children: [
                      Container(
                        width: 200,
                        height: 226,
                      ),
                      Image.asset(
                        "assets/images/movie-1.png",
                        width: 200,
                        height: 210,
                      ),
                      Positioned(
                        bottom: -10,
                        left: -10,
                        child: Text(
                          "1",
                          style: TextStyle(
                            color: Color.fromRGBO(36, 42, 50, 1),
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0), // Смещение обводки
                                color: Color.fromRGBO(2, 150, 229,
                                    1), // Цвет обводки  // Размытие обводки
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
                    ]);
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TabBar(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  indicatorColor: Color.fromRGBO(58, 63, 71, 1),
                  unselectedLabelColor: Color.fromRGBO(255, 255, 255, 1),
                  labelColor: Color.fromRGBO(255, 255, 255, 1),
                  labelStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  dividerHeight: 0,
                  controller: _tabController,
                  tabs: [
                    Tab(text: "Now playing"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Top rated"),
                    Tab(text: "Popular"),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GridView.custom(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 14.0,
                      crossAxisSpacing: 14.0,
                      mainAxisExtent: 146,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        child: Image.asset(
                          "assets/images/moive-3.png",
                          fit: BoxFit.fill,
                        ),
                      );
                    }),
                  ),
                  Icon(Icons.directions_bike),
                  Icon(Icons.movie),
                  Icon(Icons.music_video),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
