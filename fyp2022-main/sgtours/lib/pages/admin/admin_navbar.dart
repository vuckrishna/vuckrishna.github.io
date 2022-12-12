import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:sgtours/pages/admin/POISearchAdmin.dart';
import 'package:sgtours/pages/admin/admin_homepage.dart';
import 'package:sgtours/pages/admin/admin_manageUser.dart';
import 'package:sgtours/pages/forum/Forum_Main.dart';
import 'package:sgtours/pages/user/poi/poi_showmore_admin.dart';

class Admin_Navbar extends StatefulWidget {
  int currentIndex;
  Admin_Navbar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<Admin_Navbar> createState() => _Admin_NavbarState();
}

class _Admin_NavbarState extends State<Admin_Navbar> {
  int currentIndex = 0;
  final screens = [
    Admin_Homepage(),
    Admin_ManageUser(),
    Forum(),
    POISearchAdmin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: widget.currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.red,
            currentIndex: widget.currentIndex,
            onTap: (index) => setState(() => widget.currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                //backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
                //backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum),
                label: 'Forum',
                //backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.place),
                label: 'Interest',
                //backgroundColor: Colors.black
              ),
            ]));
  }
}
