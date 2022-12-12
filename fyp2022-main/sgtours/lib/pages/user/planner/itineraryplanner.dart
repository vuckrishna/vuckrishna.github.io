import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';
import 'package:sgtours/model/POIModel.dart';
import 'package:sgtours/model/Planner.dart';
import "dart:collection";
import 'package:intl/intl.dart';

class itineraryplanner extends StatefulWidget {
  const itineraryplanner({Key? key}) : super(key: key);

  @override
  State<itineraryplanner> createState() => _itineraryplannerState();
}

class _itineraryplannerState extends State<itineraryplanner> {
  Future<SplayTreeMap<String, List<Planner>>> getPlanner() async {
    List<Planner> plannerList = [];
    final db = FirebaseFirestore.instance;

    var planner = await db
        .collection("Planner")
        .where(FieldPath.documentId, whereIn: UserModel.getUser().planner)
        .get();

    planner.docs.forEach((element) {
      plannerList.add(Planner.init(element.id, element.data()));
    });

    SplayTreeMap<String, List<Planner>> datePoiMap =
        SplayTreeMap<String, List<Planner>>(((a, b) => DateFormat('d MMMM yyyy')
            .parse(a)
            .compareTo(DateFormat('d MMMM yyyy').parse(b))));

    plannerList.forEach((element) {
      if (!datePoiMap.containsKey(element.date)) datePoiMap[element.date] = [];
      datePoiMap[element.date]!.add(element);
    });

    return datePoiMap;
  }

  Future<List<POIModel>> getPOI(List<Planner> plannerList) async {
    List<POIModel> poiList = [];
    List<String> poiIdList = plannerList.map((e) => e.poi).toList();
    final db = FirebaseFirestore.instance;

    var allpoi = await db
        .collection("POI")
        .where(FieldPath.documentId, whereIn: poiIdList)
        .get();

    allpoi.docs.forEach((e) {
      poiList.add(POIModel.init(e.id, e.data()));
    });
    return poiList;
  }

  Future<dynamic> deletePOIFromItinerary(Planner planner) async {
    final db = FirebaseFirestore.instance;
    await db.collection("Planner").doc(planner.id).delete().then((value) async {
      db.collection("Account").doc(UserModel.getUser().id).update({
        "planner": FieldValue.arrayRemove([planner.id])
      });
      UserModel.getUser().planner!.remove(planner.id);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Itinerary Planner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //       constraints: BoxConstraints(),
        //       onPressed: () {
        //         setState(() {});
        //       },
        //       icon: Icon(Icons.refresh)),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<Map<String, List<Planner>>>(
                future: getPlanner(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    SplayTreeMap<String, List<Planner>> mapData = snapshot.data;
                    return ListView.builder(
                      itemCount: mapData.length,
                      itemBuilder: (BuildContext context, int mapIndex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                mapData.keys.elementAt(mapIndex),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              decoration: BoxDecoration(),
                            ),
                            FutureBuilder<List<POIModel>>(
                              future:
                                  getPOI(mapData.values.elementAt(mapIndex)),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  List<POIModel> data = snapshot.data;
                                  return ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(height: 3),
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => POIPage(
                                                        poimodel: data[index],
                                                        currentIndex: 5,
                                                      ))),
                                          child: Card(
                                            child: Row(children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  child: Image.network(
                                                      data[index].photourl,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(data[index].name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900)),
                                                      Text(data[index].address)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      deletePOIFromItinerary(
                                                          mapData.values
                                                              .elementAt(
                                                                  mapIndex)
                                                              .elementAt(
                                                                  index)),
                                                  icon:
                                                      const Icon(Icons.delete))
                                            ]),
                                          ),
                                        );
                                      });
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Center(
                      child: Text(
                          'No POI added to your planner\nSearch for POI and add them in!',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)));
                }),
          ),
        ),
      ),
    );
  }
}
