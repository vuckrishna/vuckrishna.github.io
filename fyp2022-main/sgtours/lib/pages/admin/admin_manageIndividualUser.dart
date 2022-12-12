// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/userModel.dart';

class admin_manageIndividualUser extends StatefulWidget {
  const admin_manageIndividualUser({required this.userEmail});

  final String userEmail;

  @override
  _admin_manageIndividualUserState createState() =>
      _admin_manageIndividualUserState();
}

class _admin_manageIndividualUserState
    extends State<admin_manageIndividualUser> {
  Future<List<UserModel>> getUserDetailPage() async {
    final db = FirebaseFirestore.instance;
    List<UserModel> userDetailList = [];

    var fullDetails = await db
        .collection("Account")
        .where("email", isEqualTo: widget.userEmail)
        .get();

    fullDetails.docs.forEach((e) {
      // print (e.data());
      userDetailList.add(UserModel.fromJson(e.id, e.data()));
    });

    return userDetailList;
  }

  Future<String> getImage(String imageUrl) async {
    final db = FirebaseStorage.instance;
    return await db.ref(imageUrl).getDownloadURL();
  }

  void deleteAcc(String docID) async {
    final db = FirebaseFirestore.instance;
    await db.collection("Account").doc(docID).delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('User Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder<List<UserModel>>(
                  future: getUserDetailPage(),
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: FutureBuilder(
                                      future: data[index].photourl == null ||
                                              data[index].photourl == ''
                                          ? getImage('profilepic/noimg.png')
                                          : getImage(data[index].photourl!),
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
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                ),

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
                                            data[index].name!,
                                            style: TextStyle(
                                                  fontSize: 20)
                                          ),
                                        )
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
                                            data[index].email!,
                                            style: TextStyle(
                                                  fontSize: 20)
                                          ),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Text('Role:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20)),
                                        ),
                                        TableCell(
                                          child: Text(
                                            data[index].role!,
                                            style: TextStyle(
                                                  fontSize: 20)
                                          ),
                                        )
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
                                            data[index].accState!,
                                            style: TextStyle(
                                                  fontSize: 20)
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // Text(data[index].name!,
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w900,
                                //         fontSize: 35)),
                                // Text(data[index].email!),
                                // Text(data[index].role!),
                                // Text(data[index].accState!),

                                //CAN ADD BUTTON TO "BAN" USER, ETC ETC, see what u wan to do..
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    child: Text('Remove/Ban User'),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                content: Text(
                                                    'Are you sure you want to remove ${data[index].name}?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteAcc(
                                                          data[index].id!);
                                                      int count = 0;
                                                      Navigator.of(context)
                                                          .popUntil((_) =>
                                                              count++ >= 2);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ));
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  })
            ],
          ),
        ));
  }
}
