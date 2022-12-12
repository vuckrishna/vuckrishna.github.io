// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/admin/admin_FullReqDetailBOPage.dart';
import 'package:sgtours/pages/admin/admin_FullReqDetailLOLPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admin_ViewAccountRequest extends StatefulWidget {
  const Admin_ViewAccountRequest({Key? key}) : super(key: key);

  @override
  State<Admin_ViewAccountRequest> createState() =>
      _Admin_ViewAccountRequestState();
}

class _Admin_ViewAccountRequestState extends State<Admin_ViewAccountRequest> {
  static Future<List<UserModel>> getAccReq() async {
    final db = FirebaseFirestore.instance;
    List<UserModel> accReqList = [];

    var allAccReq = await db
        .collection("Account")
        .where("accState", whereIn: ["Pend(BO)", "Pend(LOL)"]).get();

    allAccReq.docs.forEach((e) {
      //print (e.data());
      UserModel obj = UserModel.fromJson(e.id, e.data());
      accReqList.add(obj);
    });

    return accReqList;
  }

  void approveAccBO(String docID) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("Account")
        .doc(docID)
        .update({"accState": "active", "articles": []});

    Fluttertoast.showToast(
        msg: "Account has been approved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  void approveAccLOL(String docID) async {
    final db = FirebaseFirestore.instance;

    await db.collection('Account').doc(docID).get().then((value) {
      db
          .collection("Account")
          .doc(docID)
          .update({"accState": "active", "role": "LOL"});
      db.collection("Guides").add({
        "author": value["name"],
        "authorId": docID,
        "guideIds": [],
        "imageUrl": value["photourl"],
      });

      FirebaseAuth.instance.sendPasswordResetEmail(email: value["email"]);
    });

    Fluttertoast.showToast(
        msg: "Account has been approved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    setState(() {});
  }

  void deleteAcc(String docID) async {
    final db = FirebaseFirestore.instance;
    await db.collection("Account").doc(docID).delete();
    setState(() {});

    Fluttertoast.showToast(
        msg: "Account has been deleted",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

  void remainUser(String docID) async {
    final db = FirebaseFirestore.instance;
    await db.collection("Account").doc(docID).update({"accState": "active"});

    Fluttertoast.showToast(
        msg: "Request has been disapproved",
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
          title: Text('Manage Account Requests',
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
              FutureBuilder<List<UserModel>>(
                  future: getAccReq(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<UserModel> data = snapshot.data;

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
                                      Expanded(child: Text(data[index].name!)),
                                      Expanded(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child:
                                                  Text(data[index].accState!))),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            if (data[index].accState ==
                                                "Pend(LOL)") {
                                              Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) =>
                                                      admin_FullReqDetailLOLPage(
                                                    verifyDocumentID:
                                                        data[index]
                                                            .verifyDocumentID!,
                                                    emailAddress:
                                                        data[index].email!,
                                                  ),
                                                ),
                                              );
                                            } else if (data[index].accState ==
                                                "Pend(BO)") {
                                              Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) =>
                                                      admin_FullReqDetailBOPage(
                                                    accDocID: data[index].id!,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.info_outline)),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            if (data[index].role == "BO") {
                                              approveAccBO(data[index].id!);
                                            } else {
                                              approveAccLOL(data[index].id!);
                                            }
                                          },
                                          icon: Icon(Icons.check_circle)),
                                      IconButton(
                                          // padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            if (data[index].role == "BO") {
                                              deleteAcc(data[index].id!);
                                            } else {
                                              remainUser(data[index].id!);
                                            }
                                          },
                                          icon: Icon(Icons.cancel)),
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
