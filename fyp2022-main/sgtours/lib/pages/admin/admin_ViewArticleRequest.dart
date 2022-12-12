// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sgtours/model/Article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/pages/user/article/ViewArticle.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Admin_ViewArticleRequest extends StatefulWidget {
  const Admin_ViewArticleRequest({Key? key}) : super(key: key);

  @override
  State<Admin_ViewArticleRequest> createState() =>
      _Admin_ViewArticleRequestState();
}

class _Admin_ViewArticleRequestState extends State<Admin_ViewArticleRequest> {
  static Future<List<Article>> getArtReq() async {
    final db = FirebaseFirestore.instance;
    List<Article> articleList = [];

    var allArticles = await db.collection("Articles").where("artState",
        whereIn: ["pending approval", "pending deletion"]).get();

    allArticles.docs.forEach((e) {
      Article articleObj = Article.init(e.id, e.data());
      if (e.data()["imageUrl"] != null)
        articleObj.imageUrl = e.data()["imageUrl"];
      articleList.add(articleObj);
    });

    return articleList;
  }

  void approveArticle(String docID) async {
    final db = FirebaseFirestore.instance;
    await db.collection("Articles").doc(docID).update({"artState": "approved"});

    Fluttertoast.showToast(
        msg: "Article has been approved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  void disapproveArticle(String docID) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("Articles")
        .doc(docID)
        .update({"artState": "disapproved"});

    Fluttertoast.showToast(
        msg: "Article has been disapproved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  void deleteArticle(String docID) async {
    final db = FirebaseFirestore.instance;
    await db.collection("Articles").doc(docID).update({"artState": "deleted"});

    Fluttertoast.showToast(
        msg: "Article has been deleted",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Manage Article Requests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          width: MediaQuery.of(context).size.width,
          // height: 200,
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Article>>(
              future: getArtReq(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Article> data = snapshot.data;

                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.all(10)),
                                Text("Title: ${data[index].title}"),
                                SizedBox(height: 10),
                                Text("Author: ${data[index].author}"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        // padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (context) => ViewArticle(
                                                article: data[index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.info_outline)),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          primary: Colors.red,
                                        ),
                                        onPressed: () => data[index].artState ==
                                                "pending approval"
                                            ? approveArticle(data[index].id!)
                                            : deleteArticle(data[index].id!),
                                        child: Text(data[index].artState ==
                                                "pending approval"
                                            ? "Approve"
                                            : "Delete")),
                                    SizedBox(width: 5),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          primary: Colors.grey,
                                        ),
                                        onPressed: () => data[index].artState ==
                                                "pending approval"
                                            ? disapproveArticle(data[index].id!)
                                            : approveArticle(data[index].id!),
                                        child: Text('Disapprove'))
                                    // IconButton(
                                    //     // padding: EdgeInsets.zero,
                                    //     constraints: BoxConstraints(),
                                    //     onPressed: () {
                                    //       approveArticle(data[index].id!);
                                    //     },
                                    //     icon: Icon(Icons.check_circle)),
                                    // IconButton(
                                    //     // padding: EdgeInsets.zero,
                                    //     constraints: BoxConstraints(),
                                    //     onPressed: () {
                                    //       disapproveArticle(data[index].id!);
                                    //     },
                                    //     icon: Icon(Icons.cancel)),
                                    // IconButton(
                                    //     // padding: EdgeInsets.zero,
                                    //     constraints: BoxConstraints(),
                                    //     onPressed: () {
                                    //       deleteArticle(data[index].id!);
                                    //     },
                                    //     icon: Icon(Icons.delete)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              }),
        ))));
  }
}
