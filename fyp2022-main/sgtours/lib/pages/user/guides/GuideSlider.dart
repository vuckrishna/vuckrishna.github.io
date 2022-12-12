import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';

class GuideSlider extends StatelessWidget {
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
    return FutureBuilder<List<Guides>>(
        future: getGuide(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Guides> data = snapshot.data;
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
                                  LolGuideThread(lolGuide: data[index])));
                        },
                        child: Container(
                          width: 140,
                          height: 140,
                          child: FutureBuilder<String>(
                              future: data[index].imageUrl != null
                                  ? getImage(data[index].imageUrl!)
                                  : null,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(snapshot.data!,
                                          fit: BoxFit.contain));
                                }
                                return Center(
                                  child: Text(
                                    data[index].author,
                                  ),
                                );
                              }),
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
                                child: Text(data[index].author,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)))
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, index) => SizedBox(width: 15),
                itemCount: 4);
          }
          return Container();
        });
  }
}
