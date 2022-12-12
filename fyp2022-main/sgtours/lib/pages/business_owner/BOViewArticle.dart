import 'package:flutter/material.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/article/ViewArticle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgtours/model/Article.dart';

class BOViewArticle extends StatefulWidget {
  BOViewArticle({Key? key}) : super(key: key);

  @override
  State<BOViewArticle> createState() => _BOViewArticleState();
}

class _BOViewArticleState extends State<BOViewArticle> {
  static Future<List<Article>> getArticle() async {
    List<Article> articleList = [];
    final db = FirebaseFirestore.instance;

    var allArticle = await db
        .collection("Articles")
        .where("authorId", isEqualTo: UserModel.getUser().id!)
        .where("artState", isEqualTo: "approved")
        .get();

    allArticle.docs.forEach((e) {
      Article articleObj = Article.init(e.id, e.data());
      if (e.data()["imageUrl"] != null)
        articleObj.imageUrl = e.data()["imageUrl"];
      articleList.add(articleObj);
    });

    return articleList;
  }

  void setArticleAsDelete(Article article) async {
    final db = FirebaseFirestore.instance;

    await db
        .collection("Articles")
        .doc(article.id)
        .update({"artState": "pending deletion"}).then(
            (value) => UserModel.getUser().articles!.add(article.id));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('View Approved Articles'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder<List<Article>>(
                  future: getArticle(),
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
                                          padding: EdgeInsets.only(left: 10)),
                                      Expanded(child: Text(data[index].title)),
                                      IconButton(
                                          constraints: BoxConstraints(),
                                          onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewArticle(
                                                        article: data[index],
                                                      ))),
                                          icon: Icon(Icons.info_outline)),
                                      IconButton(
                                          constraints: BoxConstraints(),
                                          onPressed: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: const Text(
                                                      'Delete Article'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this article?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        setArticleAsDelete(
                                                            data[index]),
                                                        Navigator.pop(context)
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          icon: Icon(Icons.cancel)),
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
        ),
      ),
    );
  }
}
