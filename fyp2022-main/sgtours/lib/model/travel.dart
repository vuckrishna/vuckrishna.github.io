import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/article/ArticlePage2.dart';
import 'package:sgtours/pages/user/article/ArticlePage3.dart';
import 'package:sgtours/pages/user/favourite/FavouritePage.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_List.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';
import 'package:sgtours/pages/user/article/ViewArticle.dart';
import 'package:sgtours/pages/user/nearby/nearby_showmore.dart';

class Travel {
  String name;
  String location;
  String url;
  Widget? page;

  Travel(this.name, this.location, this.url, this.page);

  // static List<Travel> generateArticle() {
  //   return [
  //     Travel('Formula 1', 'Place 5', 'lib/images/f1.jpg', ArticlePage2()),
  //     Travel('Anytime Fitness', 'Place 6', 'lib/images/af.jpg', ArticlePage()),
  //     Travel('Citizen Farm', 'Place 7', 'lib/images/citizenfarm.jpg',
  //         ArticlePage3()),
  //     // Travel(
  //     //     'Raffles Hotel', 'Place 8', 'lib/images/raffleshotel.jpg', POIPage()),
  //     Travel('Formula 1', 'Place 5', 'lib/images/f1.jpg', ArticlePage2()),
  //   ];
  // }

  // static List<Travel> generateGuides() {
  //   return [
  //     Travel('Naomi Neo', 'Place 5', 'lib/images/nmn.jpg', LolGuideList()),
  //     Travel('SGAG', 'Place 6', 'lib/images/sgag.png', null),
  //     Travel('TheSmartLocal', 'Place 7', 'lib/images/tsl.png', null),
  //     Travel('Benjamin Kheng', 'Place 8', 'lib/images/bk.jpg', null),
  //   ];
  // }

  static List<Travel> generatePOI() {
    return [
      Travel('Universal Studio', 'Place 5', 'lib/images/USS.jpg', null),
      Travel('Singapore Museum', 'Place 6', 'lib/images/home_sgmuseum.jpg',
          null),
      // Travel(
      //     'Marina Bay Sands', 'Place 7', 'lib/images/home_mbs.jpg', POIPage()),
      Travel('Garden By The Bay', 'Place 8', 'lib/images/gbtb.jpg', null),
    ];
  }

  static List<Travel> generateNearby() {
    return [
      Travel(
          'Shopping Mall',
          'Place 5',
          'lib/images/shoppingmall.jpg',
          Nearby_ShowMore(
            type: 'shopping_mall',
          )),
      Travel(
          'Restaurant',
          'Place 6',
          'lib/images/restaurant.jpg',
          Nearby_ShowMore(
            type: 'restaurant',
          )),
      Travel(
          'MRT Station',
          'Place 7',
          'lib/images/mrt.jpg',
          Nearby_ShowMore(
            type: 'subway_station',
          )),
      Travel(
          'Taxi Stand',
          'Place 8',
          'lib/images/taxi.jpg',
          Nearby_ShowMore(
            type: 'taxi_stand',
          )),
    ];
  }
}
