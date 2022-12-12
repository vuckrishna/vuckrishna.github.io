import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/POIModel.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/user/navigationbar.dart';
import 'package:sgtours/pages/user/poi/map_utils.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sgtours/model/reviewModel.dart';

class POIAdmin extends StatefulWidget {
  final POIModel poimodel;
  const POIAdmin({Key? key, required this.poimodel}) : super(key: key);

  @override
  _POIAdminState createState() => _POIAdminState();
}

class _POIAdminState extends State<POIAdmin> {
  double avgRating = 0.0;

  Future<List<Review>> fetchReviews() async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=${widget.poimodel.placeid}&key=AIzaSyDVt-02Ix0eO76-Ng45VNbxFFDQGEy9Z3Q'));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      List<dynamic> results = responseBody["result"]['reviews'];
      List<Review> ReviewList = [];

      for (var element in results) {
        ReviewList.add(Review.fromJson(element));
      }

      return ReviewList;
    }

    throw Exception('Fail to load review');
  }

  Future getAvgRating() async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=${widget.poimodel.placeid}&key=AIzaSyDVt-02Ix0eO76-Ng45VNbxFFDQGEy9Z3Q'));

    var responseBody = jsonDecode(response.body);
    return responseBody["result"]["rating"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //TOP BUTTONS
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 400,
                  child: Image.network(
                    widget.poimodel.photourl,
                      // 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.poimodel.photourl}&key=<API_KEY>',
                      fit: BoxFit.fill),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(widget.poimodel.name,
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(widget.poimodel.description,
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () => {
                                  MapUtils.openMap(
                                      widget.poimodel.lat,
                                      widget.poimodel.long,
                                      widget.poimodel.placeid)
                                },
                            icon: Icon(Icons.location_on_outlined),
                            iconSize: 35,
                            color: Colors.grey),
                        IconButton(
                            onPressed: () {
                              launchURL(widget.poimodel.website);
                            },
                            icon: Icon(Icons.web),
                            iconSize: 35,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text('Review', style: TextStyle(fontSize: 20)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FutureBuilder(
                                    future: getAvgRating(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return SmoothStarRating(
                                            color: Colors.red,
                                            borderColor: Colors.red,
                                            rating: snapshot.data,
                                            filledIconData: Icons.star,
                                            halfFilledIconData: Icons.star_half,
                                            defaultIconData: Icons.star_border,
                                            starCount: 5,
                                            allowHalfRating: true,
                                            spacing: 2.0,
                                            size: 20.0);
                                      }
                                      return Container();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            MapUtils.openMap(
                              widget.poimodel.lat,
                              widget.poimodel.long,
                              widget.poimodel.placeid,
                            );
                          },
                          child: const Text('Show All'),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(90, 30.0),
                            primary: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<Review>>(
                    future: fetchReviews(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<Review> data = snapshot.data;
                        return ListView.separated(
                            padding: EdgeInsets.only(top: 0),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 3),
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Row(children: [
                                  Container(
                                    width: 50,
                                    alignment: Alignment.topCenter,
                                    child: Image.network(data[index].photourl,
                                        fit: BoxFit.fill),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Row(
                                              children: [
                                                Text(data[index].name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900)),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: SmoothStarRating(
                                                      color: Colors.red,
                                                      borderColor: Colors.red,
                                                      rating: data[index]
                                                          .rating
                                                          .toDouble(),
                                                      // isReadOnly: true,
                                                      filledIconData:
                                                          Icons.star,
                                                      halfFilledIconData:
                                                          Icons.star_half,
                                                      defaultIconData:
                                                          Icons.star_border,
                                                      starCount: 5,
                                                      allowHalfRating: true,
                                                      spacing: 2.0,
                                                      size: 20.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child:
                                                Text(data[index].relativetime),
                                          ),
                                          Text(data[index].content)
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> launchURL(String urlString) async {
  if (await canLaunch(urlString)) {
    await launch(urlString);
  } else {
    print("Can\'t launch URL");
  }
}
