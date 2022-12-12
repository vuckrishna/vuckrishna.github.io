import 'package:flutter/material.dart';
import 'package:sgtours/model/Article.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ViewArticle extends StatefulWidget {
  Article article;
  ViewArticle({Key? key, required this.article}) : super(key: key);

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

Future<String> getImage(String imageUrl) async {
  final db = FirebaseStorage.instance;
  return await db.ref(imageUrl).getDownloadURL();
}

class _ViewArticleState extends State<ViewArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TOP BUTTONS
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        title: Text('View Article',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Visibility(
              visible: UserModel.getUser().role == "admin" ? false : true,
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                   Share.share(widget.article.content,
                    subject: 'Check out ${widget.article.author}\'s Article!');
                },
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.article.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text(widget.article.author),
            Text(DateFormat.yMMMMd('en_US').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(widget.article.dateCreated)))),

            //ARTICLE CONTENT

            Wrap(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: FutureBuilder(
                    future: widget.article.imageUrl != null
                        ? getImage(widget.article.imageUrl!)
                        : null,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                Text(widget.article.content),
              ],
            )
          ],
        ),
      )),
    );
  }
}
