// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/Article.dart';
import 'package:sgtours/pages/user/article/ViewArticle.dart';

class Article_ShowMore extends StatefulWidget {
  const Article_ShowMore({Key? key}) : super(key: key);

  @override
  State<Article_ShowMore> createState() => _Article_ShowMoreState();
}

class _Article_ShowMoreState extends State<Article_ShowMore> {
  Future<List<Article>> getArticle() async {
    final db = FirebaseFirestore.instance;
    List<Article> articleList = [];

    var allArticles = await db
        .collection("Articles")
        .where("artState", isEqualTo: "approved")
        .get();

    allArticles.docs.forEach((e) {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('View Articles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: FutureBuilder<List<Article>>(
                  future: getArticle(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Article> data = snapshot.data;
                      return ListView.separated(
                        padding: EdgeInsets.all(20),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 20),
                        itemCount: data.length < 4 ? data.length : 4,
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
                                                        ViewArticle(
                                                            article:
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
                                                    data[index].title,
                                                  ),
                                                );
                                              }))),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text(data[index].title,
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
