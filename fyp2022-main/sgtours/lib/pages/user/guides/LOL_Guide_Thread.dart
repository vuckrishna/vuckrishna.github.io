// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/guides/DateFormatter.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread_View.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Create.dart';

class LolGuideThread extends StatefulWidget {
  final Guides lolGuide;
  const LolGuideThread({Key? key, required this.lolGuide}) : super(key: key);

  @override
  State<LolGuideThread> createState() => _LolGuideThreadState();
}

class _LolGuideThreadState extends State<LolGuideThread> {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();

  Future<List<LolGuides>> getGuide() async {
    List<LolGuides> lolGuideList = [];

    var allLolGuides = await db
        .collection("LolGuides")
        // .where("title", isGreaterThanOrEqualTo: searchController.text)
        // .where("title", isLessThanOrEqualTo: searchController.text + '~')
        .where(FieldPath.documentId, whereIn: widget.lolGuide.guideIds)
        .get();

    allLolGuides.docs.forEach((e) {
      //  {
      if (e
              .data()["title"]
              .toString()
              .toUpperCase()
              .contains(searchController.text.toUpperCase()) &&
          e.data()["guideState"] == "approved") {
        LolGuides guideObj = LolGuides.init(e.id, e.data());
        if (e.data()["imageUrl"] != null)
          guideObj.imageUrl = e.data()["imageUrl"];
        lolGuideList.add(guideObj);
      }
      // }
    });

    lolGuideList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    // setState(() {});
    return lolGuideList;
  }

  void deleteGuide(String id) async {
    // await db.collection("LolGuides").doc(id).get().then(
    //   (value) {
    //     LolGuides data = LolGuides.init(id, value.data()!);
    //     data.commentIds.forEach((element) async {
    //       await db.collection("LolGuidesComments").doc(element).delete();
    //     });
    //   },
    // );
    // await db.collection("LolGuides").doc(id).delete();
    // await db.collection("Guides").doc(widget.lolGuide.id).update({
    //   "guideIds": FieldValue.arrayRemove([id])
    // });
    await db
        .collection("LolGuides")
        .doc(id)
        .update({"guideState": "pending deletion"});
    setState(() {});
  }

  void editGuide(String title, String guideId) async {
    await db.collection("LolGuides").doc(guideId).update({"title": title});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('LOL Itinerary Guides',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              // padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(children: [
          SizedBox(height: 10),
          Row(
            children: [
              Text("${widget.lolGuide.author} Guides",
                  style: TextStyle(
                    fontSize: 1 * MediaQuery.of(context).size.height * 0.025,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(child: Container()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: 1 * MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.search),
                    prefixIconConstraints: BoxConstraints(
                      minHeight: 32,
                      minWidth: 32,
                    )),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 130,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: FutureBuilder<List<LolGuides>>(
                future: getGuide(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<LolGuides> data = snapshot.data;
                    return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 3),
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var verboseDateTimeRepresentation = DateFormatter()
                              .getVerboseDateTimeRepresentation(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(data[index].lastUpdated)));
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LolGuideThread_View(
                                        lolGuide: data[index]))),
                            child: Card(
                              child: Row(children: [
                                // Container(
                                //     padding: EdgeInsets.all(10),
                                //     child: Icon(Icons.abc_rounded)),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].title),
                                        Text(
                                          data[index].author,
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.4)),
                                        ),
                                        Text(
                                          "Replies: ${data[index].commentIds.length}, Last Updated: ${verboseDateTimeRepresentation}",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.4)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: UserModel.getUser().id ==
                                          widget.lolGuide.authorId ||
                                      UserModel.getUser().role == "admin",
                                  child: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                    ),
                                    itemBuilder: ((context) => [
                                          PopupMenuItem(
                                              child: Text('Edit'),
                                              value: 'edit'),
                                          PopupMenuItem(
                                              child: Text('Delete'),
                                              value: 'delete'),
                                        ]),
                                    onSelected: (value) {
                                      // if value 1 show dialog
                                      if (value == 'edit') {
                                        TextEditingController editController =
                                            TextEditingController(
                                                text: data[index].title);
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Edit Title'),
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
                                                  editGuide(editController.text,
                                                      data[index].id!);
                                                  Navigator.pop(context);
                                                  editController.clear();
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ],
                                          ),
                                        ).then(
                                            (value) => editController.clear());
                                      } else if (value == 'delete') {
                                        deleteGuide(data[index].id!);
                                      }
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          );
                        });
                  }
                  // return Center(child: CircularProgressIndicator());
                  return Container();
                }),
          ),
        ]),
      ))),
      floatingActionButton: Visibility(
        visible: UserModel.getUser().id == widget.lolGuide.authorId,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LOL_Guide_Create(guide: widget.lolGuide)));
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
