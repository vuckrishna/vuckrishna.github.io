import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgtours/model/addPOIModel.dart';
import 'package:sgtours/pages/admin/admin_navbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class admin_CreatePOI extends StatefulWidget {
  const admin_CreatePOI({Key? key}) : super(key: key);

  @override
  State<admin_CreatePOI> createState() => _admin_CreatePOIState();
}

class _admin_CreatePOIState extends State<admin_CreatePOI> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photourlController = TextEditingController();
  TextEditingController placeidController = TextEditingController();
  String poiname = '';
  String address = '';
  double lat = 0.0;
  double long = 0.0;
  String website = '';
  String placeid = '';

  final Uri _placeidurl = Uri.parse(
      'https://developers.google.com/maps/documentation/javascript/examples/places-placeid-finder');

  Future<void> _launchplaceIDUrl() async {
    if (!await launchUrl(_placeidurl)) {
      throw 'Could not launch $_placeidurl';
    }
  }

  final db = FirebaseFirestore.instance;

  void addPOI(String name, String address, String description, double lat,
      double long, String website, String photourl, String placeid) async {
    AddPOI POIObj = AddPOI(
      name: name,
      address: address,
      description: description,
      lat: lat,
      long: long,
      website: website,
      photourl: photourl,
      placeid: placeid,
    );
    await db.collection("POI").add(POIObj.toFirestore());

    Fluttertoast.showToast(
        msg: "POI created",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

  Future<AddPOI> fetchPOIDetails() async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=${placeidController.text}&key=AIzaSyDVt-02Ix0eO76-Ng45VNbxFFDQGEy9Z3Q'));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      AddPOI newPOI = AddPOI.init(responseBody['result']);

      poiname = newPOI.name;
      address = newPOI.address;
      lat = newPOI.lat;
      long = newPOI.long;
      website = newPOI.website;
      placeid = placeidController.text;

      return newPOI;
    }

    throw Exception('Fail to load POI');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text('Create POI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextFormField(
                        controller: placeidController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Place ID',
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: Icon(Icons.line_style_outlined),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 50,
                              minWidth: 50,
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 10),
                          child: TextButton(
                              onPressed: _launchplaceIDUrl,
                              child: Text('Click here to look for Place ID')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await fetchPOIDetails();
                              setState(() {});
                            },
                            child: Text('Confirm Search'),
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              primary: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextFormField(
                          maxLines: null,
                          minLines: 1,
                          controller: descriptionController,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.line_style_outlined),
                              prefixIconConstraints: BoxConstraints(
                                minHeight: 50,
                                minWidth: 50,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextFormField(
                          controller: photourlController,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Photo Url',
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(Icons.line_style_outlined),
                              prefixIconConstraints: BoxConstraints(
                                minHeight: 50,
                                minWidth: 50,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(3),
                        },
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                child: Text('Place ID:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                              ),
                              TableCell(
                                child: Text(placeid,
                                    style: TextStyle(fontSize: 15)),
                              )
                            ],
                          ),
                          TableRow(children: <Widget>[
                            TableCell(child: SizedBox(height: 5)),
                            TableCell(child: SizedBox(height: 5)),
                          ]),
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                child: Text('Name:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                              ),
                              TableCell(
                                child: Text(poiname,
                                    style: TextStyle(fontSize: 15)),
                              )
                            ],
                          ),
                          TableRow(children: <Widget>[
                            TableCell(child: SizedBox(height: 5)),
                            TableCell(child: SizedBox(height: 5)),
                          ]),
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                child: Text('Address:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                              ),
                              TableCell(
                                child: Text(address,
                                    style: TextStyle(fontSize: 15)),
                              )
                            ],
                          ),
                          TableRow(children: <Widget>[
                            TableCell(child: SizedBox(height: 5)),
                            TableCell(child: SizedBox(height: 5)),
                          ]),
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                child: Text('Lat, Long',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                              ),
                              TableCell(
                                child: Text('${lat}, ${long}',
                                    style: TextStyle(fontSize: 15)),
                              )
                            ],
                          ),
                          TableRow(children: <Widget>[
                            TableCell(child: SizedBox(height: 5)),
                            TableCell(child: SizedBox(height: 5)),
                          ]),
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                child: Text('Website',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                              ),
                              TableCell(
                                child: Text(website,
                                    style: TextStyle(fontSize: 15)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              child: Text('Create'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                addPOI(
                                  AddPOI.getThread().name,
                                  AddPOI.getThread().address,
                                  descriptionController.text,
                                  AddPOI.getThread().lat,
                                  AddPOI.getThread().long,
                                  AddPOI.getThread().website,
                                  photourlController.text,
                                  placeid,
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Admin_Navbar(
                                            currentIndex: 3,
                                          )),
                                );
                              }),
                          SizedBox(width: 10),
                          ElevatedButton(
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                primary: Colors.grey,
                              ),
                              onPressed: () => {Navigator.pop(context)}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
