// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_List.dart';
import 'package:share_plus/share_plus.dart';
import '../../../model/LOL_Guides.dart';
import 'package:sgtours/pages/user/guides/DateFormatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:byte_flow/byte_flow.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LolGuideThread_View extends StatefulWidget {
  final LolGuides lolGuide;
  const LolGuideThread_View({Key? key, required this.lolGuide})
      : super(key: key);

  @override
  State<LolGuideThread_View> createState() => _LolGuideThread_ViewState();
}

class _LolGuideThread_ViewState extends State<LolGuideThread_View> {
  final replyController = TextEditingController();
  final db = FirebaseFirestore.instance;

  Future<List<Comment>> getComment() async {
    List<Comment> commentList = [];

    Iterator batch = chunk(widget.lolGuide.commentIds, 10).iterator;
    while (batch.moveNext()) {
      var allLolGuides = await db
          .collection("LolGuidesComments")
          .where(FieldPath.documentId, whereIn: batch.current)
          .get();

      allLolGuides.docs.forEach((e) {
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

  void addComment(String comment, LolGuides lolGuide, UserModel user) async {
    Comment commentObj = Comment(
      userId: user.id!,
      username: user.username!,
      comment: comment,
      dateCreated: DateTime.now().millisecondsSinceEpoch.toString(),
      role: user.role!,
    );

    // update LolGuidesComments
    await db
        .collection("LolGuidesComments")
        .add(commentObj.toFirestore())
        .then((snapshot) async {
      // update LolGuides
      await db.collection("LolGuides").doc(lolGuide.id).update({
        "commentIds": FieldValue.arrayUnion([snapshot.id]),
        "lastUpdated": commentObj.dateCreated,
      });
      widget.lolGuide.lastUpdated = commentObj.dateCreated;
      widget.lolGuide.commentIds.add(snapshot.id);
    });

    setState(() {});
  }

  void deleteComment(String? id) async {
    await db.collection("LolGuidesComments").doc(id).delete();
    await db.collection("LolGuides").doc(widget.lolGuide.id).update({
      "commentIds": FieldValue.arrayRemove([id])
    });
    setState(() {});
  }

  void editComment(String comment, String? id) async {
    await db
        .collection("LolGuidesComments")
        .doc(id!)
        .update({"comment": comment});
    setState(() {});
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
        title: Text(widget.lolGuide.author + '\'s Guide',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            )),
        // leading: BackButton(onPressed: () {
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => LolGuideThread(
        //               lolGuide: Guides.getGuide(widget.lolGuide.authorId))),
        //       ModalRoute.withName(UserModel.getUser().role == "admin"
        //           ? '/admin/home'
        //           : '/home'));
        // }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(widget.lolGuide.description,
                    subject: 'Check out ${widget.lolGuide.author}\'s Guide!');
              },
            ),
          ),
        ],
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
                      Text(widget.lolGuide.title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined, size: 16),
                          SizedBox(width: 5),
                          Text(widget.lolGuide.author,
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
                                      int.parse(widget.lolGuide.dateCreated))),
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
                                      child: Text(widget.lolGuide.author[0])),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.lolGuide.author),
                                  SizedBox(height: 5),
                                  FutureBuilder<String>(
                                      future: getRole(widget.lolGuide.authorId),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          var data = snapshot.data;
                                          return Text(data);
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }),
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
                                      int.parse(widget.lolGuide.dateCreated))),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                              )),
                        ),
                        Visibility(
                          visible: widget.lolGuide.imageUrl != null,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: FutureBuilder(
                                future: widget.lolGuide.imageUrl != null
                                    ? getImage(widget.lolGuide.imageUrl!)
                                    : null,
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
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
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.lolGuide.description),
                        ),
                        // Visibility(
                        //   visible: widget.lolGuide.authorId ==
                        //           UserModel.getUser().id ||
                        //       UserModel.getUser().role == 'admin',
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       TextButton(
                        //         onPressed: () {
                        //           // widget.lolGuide.description;
                        //           // setState(() {
                        //           //   widget.lolGuide.description;
                        //           // });
                        //         },
                        //         child: Text('Edit'),
                        //       ),
                        //       TextButton(
                        //         onPressed: () {
                        //           // replyList.indexOf(replyList[0]);
                        //           // setState(() {
                        //           //   replyList.removeAt(0);
                        //           // });
                        //         },
                        //         child: Text('Delete'),
                        //       )
                        //     ],
                        //   ),
                        // )
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
                                                // FutureBuilder<String>(
                                                //     future: getRole(
                                                //         data[index].userId),
                                                //     builder:
                                                //         (BuildContext context,
                                                //             AsyncSnapshot
                                                //                 snapshot) {
                                                //       if (snapshot.hasData) {
                                                //         return Text(
                                                //             snapshot.data);
                                                //       }
                                                //       return Center(
                                                //           child:
                                                //               CircularProgressIndicator());
                                                //     })
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
                  addComment(replyController.text, widget.lolGuide,
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
