import 'package:flutter/material.dart';
import 'package:sgtours/model/Article.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/article/ViewArticle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgtours/model/requests.dart';

class deleteArticle extends StatefulWidget {
  deleteArticle({Key? key}) : super(key: key);

  @override
  State<deleteArticle> createState() => _deleteArticleState();
}

class _deleteArticleState extends State<deleteArticle> {
  static Future<List<Article>> getPendingDeletionArticle() async {
    List<Article> pendingDeletionArticleList = [];
    final db = FirebaseFirestore.instance;

    var allArticle = await db
        .collection("Articles")
        .where(FieldPath.documentId,
            whereIn: UserModel.getUser().toJson()['articles'])
        .where("artState", isEqualTo: "pending deletion")
        .get();

    allArticle.docs.forEach((e) {
      Article articleObj = Article.init(e.id, e.data());
      if (e.data()["imageUrl"] != null)
        articleObj.imageUrl = e.data()["imageUrl"];
      pendingDeletionArticleList.add(articleObj);
    });

    return pendingDeletionArticleList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pending Deletion of Article'),
          backgroundColor: Colors.red,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(child: Text('Articles pending to be deleted')),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: FutureBuilder<List<Article>>(
                      future: getPendingDeletionArticle(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Article> data = snapshot.data;
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int index) {
                              return Column(
                                children: [
                                  Card(
                                    child: SizedBox(
                                      height: 80,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          Expanded(
                                              child: Text(data[index].title)),
                                          IconButton(
                                              constraints: BoxConstraints(),
                                              onPressed: () => {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewArticle(
                                                                  article: data[
                                                                      index])),
                                                    )
                                                  },
                                              icon: Icon(Icons.info_outline)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
            ],
          ),
        )));
  }
}
