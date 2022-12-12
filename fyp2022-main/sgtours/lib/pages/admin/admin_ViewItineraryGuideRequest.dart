// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:sgtours/model/requests.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/pages/admin/admin_FullIGDetailPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Admin_ViewItineraryRequest extends StatefulWidget {
  const Admin_ViewItineraryRequest({Key? key}) : super(key: key);

  @override
  State<Admin_ViewItineraryRequest> createState() =>
      _Admin_ViewItineraryRequestState();
}

class _Admin_ViewItineraryRequestState
    extends State<Admin_ViewItineraryRequest> {
  static Future<List<LolGuides>> getGuideReq() async {
    final db = FirebaseFirestore.instance;
    List<LolGuides> guideReqList = [];

    var allGuideReq = await db.collection("LolGuides").where("guideState",
        whereIn: ["pending approval", "pending deletion"]).get();

    allGuideReq.docs.forEach((e) {
      //print (e.data());
      guideReqList.add(LolGuides.init(e.id, e.data()));
    });

    guideReqList.forEach((element) {
      print(element.toJson());
    });

    return guideReqList;
  }

  void approveGuide(String docID) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("LolGuides")
        .doc(docID)
        .update({"guideState": "approved"});

    Fluttertoast.showToast(
        msg: "Guide has been approved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  void disapproveGuide(String docID) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("LolGuides")
        .doc(docID)
        .update({"guideState": "disapproved"});

    Fluttertoast.showToast(
        msg: "Guide has been disapproved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  void deleteGuide(String docID) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("LolGuides")
        .doc(docID)
        .update({"guideState": "deleted"});

    Fluttertoast.showToast(
        msg: "Guide has been deleted",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Manage Itinerary Guide Requests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          width: MediaQuery.of(context).size.width,
          // height: 200,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Article Name',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Author',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Action',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              FutureBuilder<List<LolGuides>>(
                  future: getGuideReq(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<LolGuides> data = snapshot.data;

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
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Expanded(child: Text(data[index].title)),
                                      Expanded(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(data[index].author))),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                builder: (context) =>
                                                    admin_FullIGDetailPage(
                                                  lolguides: data[index],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.info_outline)),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            approveGuide(data[index].id!);
                                          },
                                          icon: Icon(Icons.check_circle)),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            disapproveGuide(data[index].id!);
                                          },
                                          icon: Icon(Icons.cancel)),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            deleteGuide(data[index].id!);
                                          },
                                          icon: Icon(Icons.delete)),
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
                  })
            ],
          ),
        ))));
  }
}
