// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_List.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';
import 'package:sgtours/SelectAndUploadImages.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LOL_Guide_Create extends StatefulWidget {
  final Guides guide;
  const LOL_Guide_Create({Key? key, required this.guide}) : super(key: key);

  @override
  State<LOL_Guide_Create> createState() => _LOL_Guide_CreateState();
}

class _LOL_Guide_CreateState extends State<LOL_Guide_Create> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final db = FirebaseFirestore.instance;

  void addGuide(String title, String description, Guides guide) async {
    LolGuides lolGuideObj = LolGuides(
        author: guide.author,
        authorId: guide.authorId,
        commentIds: [],
        dateCreated: DateTime.now().millisecondsSinceEpoch.toString(),
        lastUpdated: DateTime.now().millisecondsSinceEpoch.toString(),
        description: description,
        title: title,
        guideState: "pending approval");

    if (SelectAndUploadButton.filePath != null) {
      lolGuideObj.imageUrl = SelectAndUploadButton.filePath;
      SelectAndUploadButton.filePath = null;
    }

    await db
        .collection("LolGuides")
        .add(lolGuideObj.toFirestore())
        .then((value) async {
      lolGuideObj.id = value.id;
      await db.collection("Guides").doc(guide.id).update({
        "guideIds": FieldValue.arrayUnion([lolGuideObj.id])
      });
      Guides.getGuide(lolGuideObj.authorId).guideIds.add(lolGuideObj.id!);
    });
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
            title: Text('Create Guide',
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
                          labelText: 'Guide Title',
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
                              if (titleController.text.length < 5) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Title should be at least 5 characters",
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);
                                return;
                              }

                              if (descriptionController.text.length < 5) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Description should be at least 10 characters",
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);
                                return;
                              }

                              if (SelectAndUploadButton.filePath == null) {
                                Fluttertoast.showToast(
                                    msg: "Please upload an image.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);
                                return;
                              }

                              addGuide(titleController.text,
                                  descriptionController.text, widget.guide);
                              Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LolGuideThread(
                                                lolGuide: Guides.getGuide(
                                                    widget.guide.authorId),
                                              )),
                                      ModalRoute.withName('/guide'))
                                  .then((value) {
                                setState(() {});
                              });
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
