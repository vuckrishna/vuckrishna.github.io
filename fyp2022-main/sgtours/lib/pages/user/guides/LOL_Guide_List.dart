// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';
import '../../../model/LOL_Guides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/pages/user/guides/DateFormatter.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LolGuideList extends StatefulWidget {
  const LolGuideList({Key? key}) : super(key: key);

  @override
  State<LolGuideList> createState() => LolGuideListState();
}

class LolGuideListState extends State<LolGuideList> {
  TextEditingController searchController = TextEditingController();

  Future<List<Guides>> getGuide() async {
    final db = FirebaseFirestore.instance;
    List<Guides> guideList = [];

    var allGuides = await db
        .collection("Guides")
        .where("author", isGreaterThanOrEqualTo: searchController.text)
        .where("author", isLessThanOrEqualTo: searchController.text + '~')
        .get();

    allGuides.docs.forEach((e) {
      guideList.add(Guides.init(e.id, e.data()));
    });

    return guideList;
  }

  Future<String> getImage(String imageUrl) async {
    final db = FirebaseStorage.instance;
    return await db.ref(imageUrl).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('LOL Itinerary Guides',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: FutureBuilder<List<Guides>>(
                    future: getGuide(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<Guides> data = snapshot.data;
                        return Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            child: Column(children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text("Local Opinion Leaders",
                                      style: TextStyle(
                                        fontSize: 1 *
                                            MediaQuery.of(context).size.height *
                                            0.025,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Expanded(child: Container()),
                                ],
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: searchController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  cursorColor: Colors.red,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Search',
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: Icon(Icons.search),
                                      prefixIconConstraints: BoxConstraints(
                                        minHeight: 32,
                                        minWidth: 32,
                                      )),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: 130,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(height: 3),
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LolGuideThread(
                                                          lolGuide:
                                                              data[index]))),
                                          child: Card(
                                            child: Row(children: [
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  width: 80,
                                                  height: 80,
                                                  child: FutureBuilder(
                                                    future: data[index]
                                                                .imageUrl !=
                                                            null
                                                        ? getImage(data[index]
                                                            .imageUrl!)
                                                        : null,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Image.network(
                                                          snapshot.data!,
                                                          fit: BoxFit.contain,
                                                        );
                                                      }
                                                      return Center(
                                                        child: Text(
                                                          data[index]
                                                              .author
                                                              .substring(0, 3),
                                                        ),
                                                      );
                                                    },
                                                  )),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(data[index].author),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        );
                                      }))
                            ]));
                      }
                      return Container();
                    }))));
  }
}
