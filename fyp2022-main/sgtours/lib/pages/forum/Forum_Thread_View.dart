// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/pages/forum/Forum_Thread.dart';
import 'package:sgtours/pages/user/guides/DateFormatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:byte_flow/byte_flow.dart';
import 'package:sgtours/model/ForumModel.dart';

class Forum_Thread_View extends StatefulWidget {
  final Thread threadObj;
  const Forum_Thread_View({Key? key, required this.threadObj})
      : super(key: key);

  @override
  State<Forum_Thread_View> createState() => _Forum_Thread_ViewState();
}

class _Forum_Thread_ViewState extends State<Forum_Thread_View> {
  final replyController = TextEditingController();
  final db = FirebaseFirestore.instance;

  Future<List<Comment>> getComment() async {
    List<Comment> commentList = [];

    Iterator batch = chunk(widget.threadObj.commentIds, 10).iterator;
    while (batch.moveNext()) {
      var allComments = await db
          .collection("ForumComments")
          .where(FieldPath.documentId, whereIn: batch.current)
          .get();

      allComments.docs.forEach((e) {
        commentList.add(Comment.init(e.id, e.data()));
      });
    }

    commentList.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    return commentList;
  }

  Future<String> getRole(String userId) async {
    final db = FirebaseFirestore.instance;
    String role = '';
    await db
        .collection("Account")
        .doc(userId)
        .get()
        .then((value) => role = value["role"]);
    return role;
  }

  void addComment(String comment, Thread thread, UserModel user) async {
    Comment commentObj = Comment(
      userId: user.id!,
      username: user.username!,
      comment: comment,
      dateCreated: DateTime.now().millisecondsSinceEpoch.toString(),
      role: user.role!,
    );

    // update LolGuidesComments
    await db
        .collection("ForumComments")
        .add(commentObj.toFirestore())
        .then((snapshot) async {
      // update Forum
      await db.collection("Forum").doc(thread.id).update({
        "commentIds": FieldValue.arrayUnion([snapshot.id]),
        "lastUpdated": commentObj.dateCreated,
      });
      widget.threadObj.lastUpdated = commentObj.dateCreated;
      widget.threadObj.commentIds.add(snapshot.id);
    });

    setState(() {});
  }

  void deleteComment(String? id) async {
    await db.collection("ForumComments").doc(id).delete();
    await db.collection("Forum").doc(widget.threadObj.id).update({
      "commentIds": FieldValue.arrayRemove([id])
    });
    setState(() {});
  }

  void editComment(String comment, String? id) async {
    await db.collection("ForumComments").doc(id!).update({"comment": comment});
    setState(() {});
  }

  void editDescription(String desc, String? id) async {
    await db.collection("Forum").doc(id!).update({"description": desc});
    widget.threadObj.description = desc;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('View Thread',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
          // leading: BackButton(onPressed: () {
          //   Navigator.pop(context);
          //   // UserModel.getUser().role == "admin"
          //   //     ? Navigator.pushAndRemoveUntil(
          //   //         context,
          //   //         MaterialPageRoute(builder: (context) => Forum_Thread()),
          //   //         ModalRoute.withName('/admin/home'))
          //   //     : Navigator.pushAndRemoveUntil(
          //   //         context,
          //   //         MaterialPageRoute(builder: (context) => Forum_Thread()),
          //   //         ModalRoute.withName('/forum/main'));
          //   // Navigator.pushAndRemoveUntil(
          //   //     context,
          //   //     MaterialPageRoute(builder: (context) => Forum_Thread()),
          //   //     (Route<dynamic> route) => false);
          // })
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: MediaQuery.of(context).size.height * 0.01,
                            color: Colors.red),
                        bottom: BorderSide(
                            width: MediaQuery.of(context).size.height * 0.01,
                            color: Colors.red),
                      ),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.threadObj.title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined, size: 16),
                          SizedBox(width: 5),
                          Text(widget.threadObj.author,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Icon(Icons.schedule, size: 16),
                          SizedBox(width: 5),
                          Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(widget.threadObj.dateCreated))),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 2,
                      color: Colors.grey.withOpacity(0.5),
                    )),
                    // color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () =>
                                    {Navigator.pushNamed(context, '/profile')},
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(widget.threadObj.author[0])),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.threadObj.author),
                                  SizedBox(height: 5),
                                  FutureBuilder<String>(
                                      future:
                                          getRole(widget.threadObj.authorId),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          var data = snapshot.data;
                                          return Text(data);
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.3),
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(widget.threadObj.dateCreated))),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.threadObj.description),
                        ),
                        Visibility(
                          visible: widget.threadObj.authorId ==
                                  UserModel.getUser().id ||
                              UserModel.getUser().role == 'admin',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  TextEditingController editController =
                                      TextEditingController(
                                          text: widget.threadObj.description);

                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Edit Comment'),
                                      content: TextField(
                                        controller: editController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Comment',
                                          alignLabelWithHint: true,
                                          isDense: true,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            editDescription(editController.text,
                                                widget.threadObj.id);
                                            Navigator.pop(context);
                                            editController.clear();
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ],
                                    ),
                                  ).then((value) => editController.clear());
                                },
                                child: Text('Edit'),
                              ),
                              // TextButton(
                              //   onPressed: () {
                              //     // replyList.indexOf(replyList[0]);
                              //     // setState(() {
                              //     //   replyList.removeAt(0);
                              //     // });
                              //   },
                              //   child: Text('Delete'),
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<List<Comment>>(
                  future: getComment(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Comment> data = snapshot.data;
                      return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10),
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    width: 2,
                                    color: Colors.grey.withOpacity(0.5),
                                  )),
                                  // color: Colors.blue,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.pushNamed(
                                                    context, '/profile')
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.red,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Text(data[index]
                                                        .username[0])),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].username),
                                                SizedBox(height: 5),
                                                Text(data[index].role)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.3),
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                            DateFormatter()
                                                .getVerboseDateTimeRepresentation(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            int.parse(data[
                                                                    index]
                                                                .dateCreated))),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(data[index].comment),
                                      ),
                                      Visibility(
                                        visible: data[index].userId ==
                                                UserModel.getUser().id ||
                                            UserModel.getUser().role == 'admin',
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                TextEditingController
                                                    editController =
                                                    TextEditingController(
                                                        text: data[index]
                                                            .comment);

                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Edit Comment'),
                                                    content: TextField(
                                                      controller:
                                                          editController,
                                                      cursorColor: Colors.red,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Comment',
                                                        alignLabelWithHint:
                                                            true,
                                                        isDense: true,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          editComment(
                                                              editController
                                                                  .text,
                                                              data[index].id);
                                                          Navigator.pop(
                                                              context);
                                                          editController
                                                              .clear();
                                                        },
                                                        child: const Text(
                                                            'Submit'),
                                                      ),
                                                    ],
                                                  ),
                                                ).then((value) =>
                                                    editController.clear());
                                              },
                                              child: Text('Edit'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deleteComment(data[index].id);
                                              },
                                              child: Text('Delete'),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.data == null) {
                      return Container();
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Reply'),
            content: TextField(
              controller: replyController,
              // keyboardType: TextInputType.multiline,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comment',
                alignLabelWithHint: true,
                isDense: true,
                // contentPadding: EdgeInsets.all(10),
              ),
              // minLines: 5,
              // maxLines: null,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  addComment(replyController.text, widget.threadObj,
                      UserModel.getUser());
                  Navigator.pop(context);
                  replyController.clear();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ).then((value) => replyController.clear()),
        backgroundColor: Colors.red,
        child: const Icon(Icons.reply),
      ),
    );
  }
}
