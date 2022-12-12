// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/forum/Forum_Thread_Create.dart';
import 'package:sgtours/pages/user/guides/DateFormatter.dart';
import 'package:sgtours/model/ForumModel.dart';
import 'package:sgtours/pages/forum/Forum_Thread_View.dart';

class Forum_Thread extends StatefulWidget {
  const Forum_Thread({Key? key}) : super(key: key);

  @override
  State<Forum_Thread> createState() => _Forum_ThreadState();
}

class _Forum_ThreadState extends State<Forum_Thread> {
  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();

  Future<List<Thread>> getThread() async {
    List<Thread> threadList = [];

    var allThreads = await db.collection("Forum").get();

    allThreads.docs.forEach((e) {
      if (e
          .data()["title"]
          .toString()
          .toUpperCase()
          .contains(searchController.text.toUpperCase())) {
        threadList.add(Thread.init(e.id, e.data()));
      }
      // }
    });

    threadList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    // setState(() {});
    return threadList;
  }

  void deleteThread(String id) async {
    await db.collection("Forum").doc(id).get().then(
      (value) {
        Thread data = Thread.init(id, value.data()!);
        data.commentIds.forEach((element) async {
          await db.collection("ForumComments").doc(element).delete();
        });
      },
    );
    await db.collection("Forum").doc(id).delete();
    setState(() {});
  }

  void editThread(String title, String threadId) async {
    await db.collection("Forum").doc(threadId).update({"title": title});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('General Discussion Forum',
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
              Text("Forum",
                  style: TextStyle(
                    fontSize: 1 * MediaQuery.of(context).size.height * 0.025,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(child: Container()),
              SizedBox(
                width: 1 * MediaQuery.of(context).size.width * 0.4,
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
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 130,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: FutureBuilder<List<Thread>>(
                future: getThread(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Thread> data = snapshot.data;
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
                                    builder: (context) => Forum_Thread_View(
                                        threadObj: data[index]))),
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
                                          data[index].authorId ||
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
                                                  editThread(
                                                      editController.text,
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
                                        deleteThread(data[index].id!);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Forum_Thread_Create()));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
