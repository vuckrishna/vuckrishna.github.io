// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/ForumModel.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/forum/Forum_Thread.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forum_Thread_Create extends StatefulWidget {
  const Forum_Thread_Create({Key? key}) : super(key: key);

  @override
  State<Forum_Thread_Create> createState() => _Forum_Thread_CreateState();
}

class _Forum_Thread_CreateState extends State<Forum_Thread_Create> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final db = FirebaseFirestore.instance;

  void addThread(String title, String description) async {
    Thread threadObj = Thread(
        author: UserModel.getUser().username!,
        authorId: UserModel.getUser().id!,
        commentIds: [],
        dateCreated: DateTime.now().millisecondsSinceEpoch.toString(),
        lastUpdated: DateTime.now().millisecondsSinceEpoch.toString(),
        description: description,
        title: title);

    await db.collection("Forum").add(threadObj.toFirestore());
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
            title: Text('Create Thread',
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
                          labelText: 'Thread Title',
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

                              addThread(titleController.text,
                                  descriptionController.text);
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
                ],
              ),
            ),
          )),
    );
  }
}
