import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';
import 'package:sgtours/model/POIModel.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  static Future<List<POIModel>> getPOI() async {
    List<POIModel> poiList = [];
    final db = FirebaseFirestore.instance;

    var allpoi = await db
        .collection("POI")
        .where(FieldPath.documentId,
            whereIn: UserModel.getUser().toJson()['favourites'])
        .get();

    allpoi.docs.forEach((e) {
      poiList.add(POIModel.init(e.id, e.data()));
    });
    return poiList;
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
          'Favourites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //       // padding: EdgeInsets.zero,
        //       constraints: BoxConstraints(),
        //       onPressed: () {
        //         setState(() {});
        //       },
        //       icon: Icon(Icons.refresh)),
        // ],
      ),
      body: FutureBuilder<List<POIModel>>(
          future: getPOI(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<POIModel> data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        data.length.toString() +
                            ' POI(s) added into your favourites! \n' +
                            'Tap into the POI to remove from favourites',
                        style: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic)),
                  ),
                  ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 3),
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => POIPage(
                                        poimodel: data[index],
                                        currentIndex: 4,
                                      ))),
                          child: Card(
                            child: Row(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.network(data[index].photourl,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900)),
                                      Text(data[index].address)
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        );
                      }),
                ],
              );
            }

            return Center(
                child: Text(
                    'No Favourites added\nSearch for POI and add them in!',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 20)));
          }),
    );
  }
}
