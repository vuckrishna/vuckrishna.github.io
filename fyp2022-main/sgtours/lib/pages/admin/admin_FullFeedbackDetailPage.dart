// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/ES_Feedback.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/userModel.dart';

class admin_FullFeedbackDetailPage extends StatefulWidget {
  const admin_FullFeedbackDetailPage({required this.ESFeedbackID});

  final String ESFeedbackID;

  @override
  _admin_FullFeedbackDetailPageState createState() => _admin_FullFeedbackDetailPageState();
}

class _admin_FullFeedbackDetailPageState extends State<admin_FullFeedbackDetailPage> {

  Future<List<ESfeedback>> getFullFeedbackDetailLOLPage() async 
  {
    final db = FirebaseFirestore.instance;
    List<ESfeedback> fullReqDetailLOLPageList = [];

    var fullDetails = await db.collection("ESFeedback").where(FieldPath.documentId, isEqualTo: widget.ESFeedbackID).get();

    fullDetails.docs.forEach((e) 
    {
      //print (e.data());
      fullReqDetailLOLPageList.add(ESfeedback.init(e.id, e.data()));
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
          title: Text('Feedback detailed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder<List<ESfeedback>>(
                  future: getFullFeedbackDetailLOLPage(),
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
                                            child: Text('Name:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].name,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('')),
                                          TableCell(
                                            child: Text('')),
                                          ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('Email:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].email,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('')),
                                          TableCell(
                                            child: Text('')),
                                          ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('Contact:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].contact,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('')),
                                          TableCell(
                                            child: Text('')),
                                          ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('Residency:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].residency,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('')),
                                          TableCell(
                                            child: Text('')),
                                          ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('Feedback Type:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].feedbacktype,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('')),
                                          TableCell(
                                            child: Text('')),
                                          ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('Subject:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].subject,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('')),
                                          TableCell(
                                            child: Text('')),
                                          ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Text('Feedback:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].feedback,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
        
                              /*
                              Text(data[index].subject),
                              Text(data[index].feedback),
                              
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
                                            )),*/
                            ],);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }
              )
          
          ],),
        )
      );
    }
}