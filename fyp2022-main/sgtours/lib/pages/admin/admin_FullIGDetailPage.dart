// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:sgtours/model/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sgtours/model/userModel.dart';

class admin_FullIGDetailPage extends StatefulWidget {
  LolGuides lolguides;
  admin_FullIGDetailPage({Key? key, required this.lolguides}) : super(key: key);

  @override
  _admin_FullIGDetailPageState createState() => _admin_FullIGDetailPageState();

}

Future<String> getImage(String imageUrl) async {
  final db = FirebaseStorage.instance;
  return await db.ref(imageUrl).getDownloadURL();
}

class _admin_FullIGDetailPageState extends State<admin_FullIGDetailPage> {

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

        body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.lolguides.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text(widget.lolguides.author),
            Text(DateFormat.yMMMMd('en_US').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(widget.lolguides.dateCreated)))),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: FutureBuilder(
                    future: widget.lolguides.imageUrl != null
                        ? getImage(widget.lolguides.imageUrl!)
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
                Text(widget.lolguides.description),
              ],
            )
          ],
        ),
      )),
      );
    }
}