import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/routing/app_routing.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final bgTheme = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(2, 159, 229, 1),
            width: 1.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index != navigationShell.currentIndex,
          );
        },
        selectedItemColor: const Color.fromRGBO(2, 150, 229, 1),
        unselectedItemColor: const Color.fromRGBO(103, 104, 109, 1),
        items: _barItems,
        backgroundColor: bgTheme,
      ),
    );
  }
}

int _getCurrentIndex(GoRouterState state) {
  final location = state.uri.toString();
  switch (location) {
    case "/":
      return 0;
    case "/search":
      return 1;
    case "/watch_list":
      return 2;
    default:
      return 0;
  }
}

void _onItemTap(int index) {
  switch (index) {
    case 0:
      router.go(AppRoutes.home);
      break;
    case 1:
      router.go(AppRoutes.search);
      break;
    case 2:
      router.go(AppRoutes.watchList);
      break;
  }
}

List<BottomNavigationBarItem> get _barItems => [
      const BottomNavigationBarItem(
        label: "Home",
        icon: Icon(
          Icons.home_filled,
        ),
      ),
      const BottomNavigationBarItem(
        label: "Search",
        icon: Icon(
          Icons.search,
        ),
      ),
      const BottomNavigationBarItem(
        label: "Watch List",
        icon: Icon(
          Icons.bookmark_border,
        ),
      ),
    ];
