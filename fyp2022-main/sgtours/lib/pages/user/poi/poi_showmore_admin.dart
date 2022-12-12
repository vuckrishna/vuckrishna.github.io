// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/travel.dart';

class POI_ShowMore_admin extends StatefulWidget {
  const POI_ShowMore_admin ({Key? key}) : super(key: key);

  @override
  State<POI_ShowMore_admin> createState() => _POI_ShowMore_adminState();
}

class _POI_ShowMore_adminState extends State<POI_ShowMore_admin> {
  final poiList = Travel.generatePOI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('View Places of Interests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: ListView.separated(
            padding: EdgeInsets.all(20),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 20),
            itemCount: poiList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          poiList[index].page as Widget));
                },
                child: Stack(alignment: Alignment.bottomRight, children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(poiList[index].url,
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        fit: BoxFit.cover)),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(poiList[index].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 1 * MediaQuery.of(context).size.width * 0.04,
                      )),
                ),
              ])
              );
            },
          )),
        ));
  }
}
