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

        

        
        body: SingleChildScrollView(
          child: Column(children: [
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
                          return 
                          SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            child: Text('UEN:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].uen,
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
                                            child: Text('NRIC:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].nric,
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
                                            child: Text('Account State:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].accState,
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
                                            child: Text('Website:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].web,
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
                                            child: Text('Description:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20)),
                                          ),
                                          TableCell(
                                            child: Text(
                                              data[index].desc,
                                              style: TextStyle(
                                                    fontSize: 20)
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
        
                              /*
                              Text(data[index].name,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10.0),
                              Text(data[index].email),
                              Text(data[index].address),
                              Text(data[index].uen),
                              Text(data[index].nric),
                              Text(data[index].accState),
                              Text(data[index].web),
                              Text(data[index].desc),
                              */
                              /*
                              Text(DateFormat.yMMMMd('en_US').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(widget.article.dateCreated)))),*/
        
                              //ARTICLE CONTENT
                              /*
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: FutureBuilder(
                                      future: data[index].imageUrl != null
                                          ? getImage(widget.article.imageUrl!)
                                          : null,
                                      builder:
                                          (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return Image.network(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                            height: 200,
                                            width: MediaQuery.of(context).size.width,
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                  Text(widget.article.content),
                                ],
                              )*/
                            ],
                          ),
                        ));
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