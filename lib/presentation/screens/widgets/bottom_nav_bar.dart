import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
            label: "Home",
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.bookmark_border,
            ),
          )
        ],
        backgroundColor: bgTheme,
      ),
    );
  }
}
