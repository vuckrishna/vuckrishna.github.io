// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../model/travel.dart';

class Nearby_ShowMorePage extends StatefulWidget {
  const Nearby_ShowMorePage({Key? key}) : super(key: key);

  @override
  State<Nearby_ShowMorePage> createState() => _Nearby_ShowMorePageState();
}

class _Nearby_ShowMorePageState extends State<Nearby_ShowMorePage> {
  final itineraryList = Travel.generateNearby();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Nearby Places',
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
            itemCount: itineraryList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var travel = itineraryList[index];
              return Stack(alignment: Alignment.bottomRight, children: [
                Material(
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                travel.page as Widget));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            itineraryList[index].url,
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            fit: BoxFit.cover,
                          ))),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(itineraryList[index].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 1 * MediaQuery.of(context).size.width * 0.04,
                      )),
                ),
              ]);
            },
          )),
        ));
  }
}
