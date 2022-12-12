// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';
import 'package:share_plus/share_plus.dart';

class admin_FullArticleDetailPage extends StatefulWidget {
  const admin_FullArticleDetailPage({required this.artDocID});

  final String artDocID;

  @override
  _admin_FullArticleDetailPageState createState() => _admin_FullArticleDetailPageState();
}

class _admin_FullArticleDetailPageState extends State<admin_FullArticleDetailPage> {

  Future<List<ArtRequests>> getFullArticleDetailPage() async 
  {
    final db = FirebaseFirestore.instance;
    List<ArtRequests> fullArticleDetailPageList = [];

    var fullDetails = await db.collection("Articles").where(FieldPath.documentId, isEqualTo: widget.artDocID).get();

    fullDetails.docs.forEach((e) 
    {
      //print (e.data());
      fullArticleDetailPageList.add(ArtRequests.init(e.id, e.data()));
    });

    return fullArticleDetailPageList;
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
          title: Text('Full LOL Request Detail',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
          actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            //child: GestureDetector(onTap: () {}, child: Icon(Icons.share)),
            child: IconButton(
                icon: Icon(Icons.share), 
                onPressed: () {Share.share("suppose to put our app url or mbs homepage url?");
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
        child: Column
          (children: [
          FutureBuilder<List<ArtRequests>>(
                future: getFullArticleDetailPage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) 
                {
                  if (snapshot.hasData) 
                  {
                    List<ArtRequests> data = snapshot.data;

                    return
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return 
                        Column(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Text(data[index].author),
                                  Text(data[index].dateCreated),
                                ],
                              )
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: [

                                  Container(
                                          height: 200,
                                          width: MediaQuery.of(context).size.width,
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
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot.data!),
                                                        fit: BoxFit.fill)),
                                                  /*child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 10.0),
                                                      Text(data[index].content),
                                                    ],
                                                  ),*/
                                                );
                                              }
                                              return Center();
                                            }
                                          )),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.0),
                                        Text(data[index].content.replaceAll('\\n', '\n')),
                                      ],
                                    ),
                                  ),
                                ],),
                              ),
                          ]);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }
            )
        
        ],)
        )
      );
    }
}