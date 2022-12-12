// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';

class Guides_ShowMore extends StatefulWidget {
  const Guides_ShowMore({Key? key}) : super(key: key);

  @override
  State<Guides_ShowMore> createState() => _Guides_ShowMoreState();
}

class _Guides_ShowMoreState extends State<Guides_ShowMore> {
  Future<List<Guides>> getGuide() async {
    final db = FirebaseFirestore.instance;
    List<Guides> guideList = [];

    var allGuides = await db.collection("Guides").get();

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
          title: Text('View Itinerary Guides',
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
                      return ListView.separated(
                        padding: EdgeInsets.all(20),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 20),
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Material(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LolGuideThread(
                                                            lolGuide:
                                                                data[index])));
                                      },
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 140,
                                          child: FutureBuilder<String>(
                                              future:
                                                  data[index].imageUrl != null
                                                      ? getImage(
                                                          data[index].imageUrl!)
                                                      : null,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover,
                                                      ));
                                                }
                                                return Center(
                                                  child: Text(
                                                    data[index].author,
                                                  ),
                                                );
                                              }))),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text(data[index].author,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 1 *
                                            MediaQuery.of(context).size.width *
                                            0.04,
                                      )),
                                ),
                              ]);
                        },
                      );
                    }
                    return Container();
                  })),
        ));
  }
}
