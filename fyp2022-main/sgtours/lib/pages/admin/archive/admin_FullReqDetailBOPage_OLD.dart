/*
// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';

class admin_FullReqDetailBOPage extends StatefulWidget {
  const admin_FullReqDetailBOPage({required this.accDocID});

  final String accDocID;

  @override
  _admin_FullReqDetailBOPageState createState() => _admin_FullReqDetailBOPageState();
}

class _admin_FullReqDetailBOPageState extends State<admin_FullReqDetailBOPage> {

  Future<List<BOFullDetail>> getFullReqDetailBOPage() async 
  {
    final db = FirebaseFirestore.instance;
    List<BOFullDetail> fullReqDetailBOPageList = [];

    var fullDetails = await db.collection("Account").where(FieldPath.documentId, isEqualTo: widget.accDocID).get();

    fullDetails.docs.forEach((e) 
    {
      //print (e.data());
      fullReqDetailBOPageList.add(BOFullDetail.init(e.id, e.data()));
    });

    return fullReqDetailBOPageList;
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
          title: Text('Full Business Owner Request Detail',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: Column(children: [
          FutureBuilder<List<BOFullDetail>>(
                future: getFullReqDetailBOPage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) 
                {
                  if (snapshot.hasData) 
                  {
                    List<BOFullDetail> data = snapshot.data;

                    return
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return Column(
                          children: [
                            Text(data[index].desc),
                            Text(data[index].uen),
                            /*Container(
                                          height: 50,
                                          width: 50,
                                          child: FutureBuilder(
                                            future: data[index].imageUrl != null
                                                ? getImage(
                                                    data[index].imageUrl)
                                                : null,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) 
                                            {
                                              if (snapshot.hasData) {
                                                return Container(
                                                  child: Image.network(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }
                                              return Center(child: CircularProgressIndicator());
                                            }
                                          )),*/
                          ],);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }
            )
        
        ],)
      );
    }
}
*/