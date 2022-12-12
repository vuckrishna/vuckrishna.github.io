// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sgtours/model/ES_Feedback.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/admin/admin_FullFeedbackDetailPage.dart';

class Admin_ViewFeedbacks extends StatefulWidget {
  const Admin_ViewFeedbacks({Key? key}) : super(key: key);

  @override
  State<Admin_ViewFeedbacks> createState() =>
      _Admin_ViewFeedbacksState();
}

class _Admin_ViewFeedbacksState extends State<Admin_ViewFeedbacks> {

  static Future<List<ESfeedback>> getFeedBack() async 
  {
    final db = FirebaseFirestore.instance;
    List<ESfeedback> feedBackList = [];

    var allFeedback = await db.collection("ESFeedback").where("feedbackState", whereIn:["Read", "Unread"]).get();

    allFeedback.docs.forEach((e) 
    {
      //print (e.data());
      feedBackList.add(ESfeedback.init(e.id, e.data()));
    });

    return feedBackList;
  }

  void checkRead(String docID) async
  {
    final db = FirebaseFirestore.instance;
    await db.collection("ESFeedback").doc(docID).update({"feedbackState": "Read"});
    setState(() {});
  }

  void checkUnread(String docID) async
  {
    final db = FirebaseFirestore.instance;
    await db.collection("ESFeedback").doc(docID).update({"feedbackState": "Unread"});
    setState(() {});
  }

  void deleteFeedback(String docID) async
  {
    final db = FirebaseFirestore.instance;
    await db.collection("ESFeedback").doc(docID).update({"feedbackState": "deleted"});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('View Feedbacks',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Name',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('User Type',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Action',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              FutureBuilder<List<ESfeedback>>(
                future: getFeedBack(),
                builder: (BuildContext context, AsyncSnapshot snapshot) 
                {
                  if (snapshot.hasData) 
                  {
                    List<ESfeedback> data = snapshot.data;

                    return
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
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
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    Expanded(child: Text(data[index].name)),
                                    Expanded(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                                data[index].feedbackState))),
                                    IconButton(
                                        // padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          Navigator.push
                                            (context, new MaterialPageRoute
                                              (builder: (context) => admin_FullFeedbackDetailPage
                                                (
                                                  ESFeedbackID: data[index].id!,
                                                ),
                                              ),
                                            );
                                        },
                                        icon: Icon(Icons.info_outline)),
                                    IconButton(
                                        // padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          checkRead(data[index].id!);
                                        },
                                        icon: Icon(Icons.check_circle)),
                                    IconButton(
                                        // padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          checkUnread(data[index].id!);
                                        },
                                        icon: Icon(Icons.cancel)),
                                    IconButton(
                                        // padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          deleteFeedback(data[index].id!);
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
               }
              )
            ],
          ),
        ))));
  }
}