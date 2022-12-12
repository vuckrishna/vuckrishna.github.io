// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import '../user/guides/LOL_Guide_List.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';
import 'package:sgtours/model/ForumModel.dart';
import 'package:sgtours/pages/user/guides/DateFormatter.dart';
import 'package:sgtours/pages/forum/Forum_Thread_View.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  Future<List<Guides>> getGuide() async {
    List<Guides> guideList = [];
    final db = FirebaseFirestore.instance;
    var allGuides = await db.collection("Guides").get();

    allGuides.docs.forEach((e) {
      guideList.add(Guides.init(e.id, e.data()));
    });

    return guideList;
  }

  Future<String> getImage(String imageUrl) async {
    final db = FirebaseStorage.instance;
    return await db.ref(imageUrl).getDownloadURL();
  }

  Future<List<Thread>> getThread() async {
    final db = FirebaseFirestore.instance;
    List<Thread> threadList = [];

    var allThreads = await db.collection("Forum").get();

    allThreads.docs.forEach((e) {
      threadList.add(Thread.init(e.id, e.data()));
    });

    threadList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    return threadList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Forum',
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
        child: Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Forum Rules",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 5),
                          Text(
                              "1. All information and instructions given within these forums is to be used at your own risk. By following or using any of this information you give up the right to hold SGTours liable for any damages.",
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          SizedBox(height: 10),
                          Text(
                              "2. All the forums are categorized by topics. Please post your questions or messages in the appropriate forum.",
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          SizedBox(height: 10),
                          Text(
                              "3. Posting links in order to generate affiliate commissions is not permitted at SGTours. Any posts that are deemed to be posted in order to generate affiliate commissions, regardless of the product being promoted, will be deleted.",
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          SizedBox(height: 10),
                          Text(
                              "4. There will be no  use of profanity on our message boards. This will not be tolerated and can lead to immediate suspension.",
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'LOL Itinerary Guides',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          Navigator.pushNamed(context, '/guide');
                        },
                        icon: Icon(Icons.arrow_forward_outlined),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Guides>>(
                      future: getGuide(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Guides> data = snapshot.data;
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 130,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5)),
                            child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 3),
                                itemCount: data.length >= 3 ? 3 : data.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LolGuideThread(
                                                  lolGuide: data[index],
                                                ))),
                                    child: Card(
                                      child: Row(children: [
                                        // Container(
                                        //     padding: EdgeInsets.all(10),
                                        //     child: Icon(Icons.abc_rounded)),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: FutureBuilder(
                                            future: data[index].imageUrl != null
                                                ? getImage(
                                                    data[index].imageUrl!)
                                                : null,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                return Container(
                                                  child: Image.network(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }
                                              return Center(
                                                child: Text(
                                                  data[index]
                                                      .author
                                                      .substring(0, 3),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].author),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                }),
                          );
                        }
                        return Container();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'General Discussion Forum',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          Navigator.pushNamed(context, '/general');
                        },
                        icon: Icon(Icons.arrow_forward_outlined),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Thread>>(
                      future: getThread(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Thread> data = snapshot.data;

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 130,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5)),
                            child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 3),
                                itemCount: data.length >= 3 ? 3 : data.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var verboseDateTimeRepresentation =
                                      DateFormatter()
                                          .getVerboseDateTimeRepresentation(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      int.parse(data[index]
                                                          .lastUpdated)));
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Forum_Thread_View(
                                                  threadObj: data[index],
                                                ))),
                                    child: Card(
                                      child: Row(children: [
                                        // Container(
                                        //     padding: EdgeInsets.all(10),
                                        //     child: Icon(Icons.abc_rounded)),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              data[index].title.substring(0, 3),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    // 'Title',
                                                    data[index].title),
                                                Text(
                                                  // 'Author',
                                                  data[index].author,
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4)),
                                                ),
                                                Text(
                                                  // 'Replies: replyCount, lastUpdated minute ago',
                                                  "Replies: ${data[index].commentIds.length}, Last Updated:${verboseDateTimeRepresentation}",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  );
                                }),
                          );
                        }
                        return Container();
                      }),
                ],
              )),
        ),
      )),
    );
  }
}
