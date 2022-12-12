//search page goes here
import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';
import 'package:sgtours/model/POIModel.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  _searchPage createState() => _searchPage();
}

class _searchPage extends State<searchPage> {
  static TextEditingController _searchController = TextEditingController();
  String searchText = '';

  //Get all POI
  static Future<List<POIModel>> getPOI() async {
    List<POIModel> poiList = [];
    final db = FirebaseFirestore.instance;

    var allpoi = await db.collection("POI").get();
    allpoi.docs.forEach((e) {
      if (e
          .data()["name"]
          .toString()
          .toUpperCase()
          .contains(_searchController.text.toUpperCase())) {
        poiList.add(POIModel.init(e.id, e.data()));
      }
    });
    return poiList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text('Search POI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<POIModel>>(
                future: getPOI(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<POIModel> data = snapshot.data;
                    return ListView.separated(
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
                                          currentIndex: 1,
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
                                        // 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${data[index].photourl}&key=AIzaSyD3-Ymjb3ncRynXxZstQE5lmXGpiJ2ASLM',
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
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ));
  }
}
