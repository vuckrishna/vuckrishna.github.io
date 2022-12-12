import 'package:flutter/material.dart';
import 'package:sgtours/pages/forum/Forum_Main.dart';
import 'package:sgtours/pages/user/planner/itineraryplanner.dart';
import 'essentials/essentials.dart';
import 'home.dart';
import 'package:sgtours/search.dart';
import 'package:sgtours/pages/user/favourite/FavouritePage.dart';
import 'package:sgtours/pages/user/profile/planner.dart';
// import 'test.dart';

class NavBar extends StatefulWidget {
  int currentIndex;
  NavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final screens = [
    HomePage(),
    searchPage(),
    Essentials(),
    Forum(),
    FavouritePage(),
    itineraryplanner(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: widget.currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            type: BottomNavigationBarType.fixed,
            currentIndex: widget.currentIndex,
            onTap: (index) => setState(() => widget.currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cases),
                label: 'Essentials',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum),
                label: 'Forum',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Planner',
              )
            ]),
      );
}
