// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';

class admin_FullReqDetailLOLPage extends StatefulWidget {
  const admin_FullReqDetailLOLPage(
      {required this.verifyDocumentID, required this.emailAddress});

  final String verifyDocumentID;
  final String emailAddress;

  @override
  _admin_FullReqDetailLOLPageState createState() =>
      _admin_FullReqDetailLOLPageState();
}

class _admin_FullReqDetailLOLPageState
    extends State<admin_FullReqDetailLOLPage> {
  Future<List<LOLFullDetail>> getFullReqDetailLOLPage() async {
    final db = FirebaseFirestore.instance;
    List<LOLFullDetail> fullReqDetailLOLPageList = [];

    var fullDetails = await db
        .collection("VerifyLOL")
        .where(FieldPath.documentId, isEqualTo: widget.verifyDocumentID)
        .get();

    fullDetails.docs.forEach((e) {
      fullReqDetailLOLPageList.add(LOLFullDetail.init(e.id, e.data()));
    });

    return fullReqDetailLOLPageList;
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<LOLFullDetail>>(
                  future: getFullReqDetailLOLPage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<LOLFullDetail> data = snapshot.data;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FixedColumnWidth(150),
                                    1: IntrinsicColumnWidth(),
                                  },
                                  children: <TableRow>[
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Text('Full Name:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20)),
                                        ),
                                        TableCell(
                                          child: Text(data[index].fullLegalName,
                                              style: TextStyle(fontSize: 20)),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(child: Text('')),
                                        TableCell(child: Text('')),
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Text('Email Address:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20)),
                                        ),
                                        TableCell(
                                          child: Text(widget.emailAddress,
                                              style: TextStyle(fontSize: 20)),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(child: Text('')),
                                        TableCell(child: Text('')),
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Text('Social Handle:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20)),
                                        ),
                                        TableCell(
                                          child: Text(data[index].handle,
                                              style: TextStyle(fontSize: 20)),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(child: Text('')),
                                        TableCell(child: Text('')),
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(child: Text('')),
                                        TableCell(child: Text('')),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  'Image',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 250,
                                    width: 250,
                                    child: FutureBuilder(
                                        future: data[index].imageUrl != null
                                            ? getImage(data[index].imageUrl)
                                            : null,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return Container(
                                              child: Image.network(
                                                snapshot.data!,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }
                                          return Center(
                                            child: Text('No Image Uploaded'),
                                          );
                                        })),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  })
            ],
          ),
        ));
  }
}
