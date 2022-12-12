// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/Article.dart';
import 'package:sgtours/SelectAndUploadImages.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Article_Create extends StatefulWidget {
  const Article_Create({Key? key}) : super(key: key);

  @override
  State<Article_Create> createState() => _Article_CreateState();
}

class _Article_CreateState extends State<Article_Create> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final db = FirebaseFirestore.instance;

  void addArticle(String title, String content) async {
    UserModel currentUser = UserModel.getUser();

    Article articleObj = Article(
        author: currentUser.name!,
        authorId: currentUser.id!,
        dateCreated: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        title: title,
        artState: "pending approval");

    if (SelectAndUploadButton.filePath != null) {
      articleObj.imageUrl = SelectAndUploadButton.filePath;
      SelectAndUploadButton.filePath = null;
    }

    await db
        .collection("Articles")
        .add(articleObj.toFirestore())
        .then((value) async {
      articleObj.id = value.id;
      await db.collection("Account").doc(currentUser.id).update({
        "articles": FieldValue.arrayUnion([articleObj.id])
      });
    });

        Fluttertoast.showToast(
        msg: "Article has been created",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text('Create Article',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: titleController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(Icons.line_style_outlined),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 32,
                            minWidth: 32,
                          )),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight:
                            1 * MediaQuery.of(context).size.height * 0.3),
                    padding: EdgeInsets.all(10),
                    child: Expanded(
                      child: Scrollbar(
                        child: TextField(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Content',
                            alignLabelWithHint: true,
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          minLines: 15,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            child: Text('Create'),
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              addArticle(titleController.text,
                                  descriptionController.text,);
                              Navigator.pop(context);


                            }),
                        SizedBox(width: 10),
                        ElevatedButton(
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              primary: Colors.grey,
                            ),
                            onPressed: () => {Navigator.pop(context)}),
                      ],
                    ),
                  ),
                  SelectAndUploadButton(),
                ],
              ),
            ),
          )),
    );
  }
}
