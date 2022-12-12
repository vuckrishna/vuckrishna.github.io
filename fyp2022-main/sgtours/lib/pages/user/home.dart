import 'package:flutter/material.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/navigationbar.dart';
import 'package:sgtours/pages/user/poi/map_utils.dart';
import 'package:sgtours/pages/welcome/login.dart';
import 'package:sgtours/pages/user/poi/poi.dart';
import 'package:sgtours/pages/user/nearby/nearby.dart';
import 'package:sgtours/pages/user/article/ArticleSlider.dart';
import 'package:sgtours/pages/user/guides/GuideSlider.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: 
        Text(
          'Discover Singapore',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onSelected: (result) {
                if (result == 0) {
                  Navigator.of(context).pushNamed('/profile');
                }
                if (result == 1) {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login())),
                      );
                }
              },
              itemBuilder: ((context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Text('Profile'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ]))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: UserModel.getUser().role == "LOL" ? true : false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome,',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Text('${UserModel.getUser().name.toString()}! (${UserModel.getUser().role.toString()})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Articles',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Show More',
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/articles/more');
                        }),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: ArticleSlider()),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Itinerary Guides',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Show More',
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/guide');
                        }),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: GuideSlider()),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Places Of Interest',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Show More',
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, '/search');
                        }),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: POI()),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "What's Nearby",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Show More',
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/nearby/more');
                        }),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: Nearby()),
        ],
      ),
    );
  }
}
