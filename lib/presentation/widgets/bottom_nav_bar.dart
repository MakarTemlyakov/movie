import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int screenIndex;
  const BottomNavBar({super.key, required this.screenIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    Color bgTheme = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Color.fromRGBO(2, 159, 229, 1),
        width: 1.0,
      ))),
      child: BottomNavigationBar(
        currentIndex: widget.screenIndex,
        onTap: (int index) {
          switch (index) {
            case   0:
              Navigator.pushReplacementNamed(context, "/");
            case 1:
              Navigator.pushReplacementNamed(context, "/search");
            case 2:
              Navigator.pushReplacementNamed(context, "/watch_list");
          }
        },
        selectedItemColor: const Color.fromRGBO(2, 150, 229, 1),
        unselectedItemColor: const Color.fromRGBO(103, 104, 109, 1),
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_filled,
            ),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: "Watch List",
            icon: Icon(
              Icons.bookmark_border,
            ),
          ),
        ],
        backgroundColor: bgTheme,
      ),
    );
  }
}
