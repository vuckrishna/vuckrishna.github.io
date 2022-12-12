import 'package:flutter/material.dart';
import 'package:sgtours/model/travel.dart';

class Nearby extends StatelessWidget {
  final _list = Travel.generateNearby();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var travel = _list[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => travel.page!)),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            travel.page as Widget));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(travel.url,
                          width: 140, height: 140, fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 20,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                          color: Colors.transparent,
                          child: Text(travel.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)))
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 15),
        itemCount: _list.length);
  }
}
