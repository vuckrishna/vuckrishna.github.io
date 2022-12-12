//search page goes here
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgtours/pages/admin/POIAdmin.dart';
import 'package:sgtours/pages/admin/admin_CreatePOI.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';
import 'package:sgtours/model/POIModel.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class POISearchAdmin extends StatefulWidget {
  const POISearchAdmin({Key? key}) : super(key: key);

  @override
  _POISearchAdmin createState() => _POISearchAdmin();
}

class _POISearchAdmin extends State<POISearchAdmin> {
  static TextEditingController _searchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photourlController = TextEditingController();
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

  void deletePOI(String docID) async {
    final db = FirebaseFirestore.instance;
    await db.collection("POI").doc(docID).delete();
    setState(() {});
  }

  void updatePOI(String docID, String description, String photourl) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("POI")
        .doc(docID)
        .update({"description": description, "photourl": photourl});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text('Manage POI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => admin_CreatePOI()),
                  );
                },
                child: Icon(Icons.add),
              ),
            )
          ],
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
                                    builder: (context) => POIAdmin(
                                          poimodel: data[index],
                                        ))),
                            child: Card(
                              child: Row(children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(data[index].photourl,
                                        // 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${data[index].photourl}&key=<API_KEY>',
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
                                        Text(data[index].address),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  // padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                      'Edit ${data[index].name}'),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'Description',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w900,
                                                                              decoration: TextDecoration.underline,
                                                                            )),
                                                                        TextFormField(
                                                                          controller: descriptionController =
                                                                              TextEditingController(text: '${data[index].description}'),
                                                                          minLines:
                                                                              1,
                                                                          maxLines:
                                                                              null,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 8.0),
                                                                          child: Text(
                                                                              'Photo URL',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w900,
                                                                                decoration: TextDecoration.underline,
                                                                              )),
                                                                        ),
                                                                        TextFormField(
                                                                          controller: photourlController =
                                                                              TextEditingController(text: '${data[index].photourl}'),
                                                                          minLines:
                                                                              1,
                                                                          maxLines:
                                                                              null,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        updatePOI(
                                                                            data[index].id!,
                                                                            descriptionController.text,
                                                                            photourlController.text);
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Update Success!",
                                                                            toastLength:
                                                                                Toast.LENGTH_SHORT,
                                                                            timeInSecForIosWeb: 1);

                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: const Text(
                                                                          'Update'),
                                                                    ),
                                                                  ],
                                                                ));
                                                  },
                                                  icon: Icon(
                                                      Icons.edit_outlined)),
                                              IconButton(
                                                  // padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  onPressed: () {
                                                    deletePOI(data[index].id!);
                                                  },
                                                  icon: Icon(Icons.delete)),
                                            ],
                                          ),
                                        ),
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
