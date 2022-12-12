import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/Article.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sgtours/model/POIModel.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';


class POI extends StatefulWidget {
  @override
  State<POI> createState() => _POIState();
}

class _POIState extends State<POI> {


  Future<List<POIModel>> getPOI() async {
    final db = FirebaseFirestore.instance;
    List<POIModel> poiList = [];

    var allGuides = await db
        .collection("POI")
        .get();

    allGuides.docs.forEach((e) {
      POIModel poiObj = POIModel.init(e.id, e.data());
      if (e.data()["photourl"] != null){
        poiObj.photourl = e.data()["photourl"];
      }
      poiList.add(poiObj);
    });

    return poiList;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<POIModel>>(
        future: getPOI(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<POIModel> data = snapshot.data;
            return ListView.separated(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  POIPage(poimodel: data[index], currentIndex: 0)));
                        },
                        child: Container(
                          width: 140,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(snapshot.data[index].photourl!,
                                            fit: BoxFit.cover),
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                                color: Colors.transparent,
                                child: Text(data[index].name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)))
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, index) => SizedBox(width: 15),
                itemCount: data.length < 4 ? data.length : 4);
          }
          return Container();
        });
  }
}
