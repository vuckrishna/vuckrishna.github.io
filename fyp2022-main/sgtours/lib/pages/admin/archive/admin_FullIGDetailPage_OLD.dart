/*
// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';

class admin_FullIGDetailPage extends StatefulWidget {
  const admin_FullIGDetailPage({required this.IGDocID});

  final String IGDocID;

  @override
  _admin_FullIGDetailPageState createState() => _admin_FullIGDetailPageState();
}

class _admin_FullIGDetailPageState extends State<admin_FullIGDetailPage> {

  Future<List<GuideRequests>> getFullIGDetailPage() async 
  {
    final db = FirebaseFirestore.instance;
    List<GuideRequests> fullIGDetailPageList = [];

    var fullDetails = await db.collection("LolGuides").where(FieldPath.documentId, isEqualTo: widget.IGDocID).get();

    fullDetails.docs.forEach((e) 
    {
      //print (e.data());
      fullIGDetailPageList.add(GuideRequests.init(e.id, e.data()));
    });

    return fullIGDetailPageList;
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
          title: Text('Full Itinerary Guide Detailed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: Column(children: [
          FutureBuilder<List<GuideRequests>>(
                future: getFullIGDetailPage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) 
                {
                  if (snapshot.hasData) 
                  {
                    List<GuideRequests> data = snapshot.data;

                    return
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return Column(
                          children: [
                            Text(data[index].title),
                            Text(data[index].author),
                            Text(data[index].description),
                            Container(
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
                                          )),
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