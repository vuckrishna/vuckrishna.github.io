import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/Article.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'ViewArticle.dart';

class ArticleSlider extends StatefulWidget {
  @override
  State<ArticleSlider> createState() => _ArticleSliderState();
}

class _ArticleSliderState extends State<ArticleSlider> {
  Future<List<Article>> getArticle() async {
    final db = FirebaseFirestore.instance;
    List<Article> articleList = [];

    var allGuides = await db
        .collection("Articles")
        .where("artState", isEqualTo: "approved")
        .get();

    allGuides.docs.forEach((e) {
      Article articleObj = Article.init(e.id, e.data());
      if (e.data()["imageUrl"] != null)
        articleObj.imageUrl = e.data()["imageUrl"];
      articleList.add(articleObj);
    });

    articleList.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

    return articleList;
  }

  Future<String> getImage(String imageUrl) async {
    final db = FirebaseStorage.instance;
    return await db.ref(imageUrl).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: getArticle(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Article> data = snapshot.data;
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
                                  ViewArticle(article: data[index])));
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
                                          fit: BoxFit.cover));
                                }
                                return Center(
                                  child: Text(
                                    data[index].title,
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
                                child: Text(data[index].title,
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
