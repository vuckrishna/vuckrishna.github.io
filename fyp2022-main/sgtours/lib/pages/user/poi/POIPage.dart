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
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgtours/model/Planner.dart';

class POIPage extends StatefulWidget {
  final POIModel poimodel;
  final int currentIndex;
  const POIPage({Key? key, required this.poimodel, required this.currentIndex})
      : super(key: key);

  @override
  _POIPageState createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {
  bool togglePlannerButtonColor = false;
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

  void _toggleFavorite() {
    List favouritelist = UserModel.getUser().toJson()['favourites'];
    bool _isFav = favouritelist.contains(widget.poimodel.id);

    setState(() {
      if (_isFav) {
        favouritelist.remove(widget.poimodel.id);

        Map<String, dynamic> updatelist = {'favourites': favouritelist};

        FirebaseFirestore.instance
            .collection('Account')
            .doc(UserModel().id)
            .update(updatelist);
      } else {
        favouritelist.add(widget.poimodel.id);

        Map<String, dynamic> updatelist = {'favourites': favouritelist};
        FirebaseFirestore.instance
            .collection('Account')
            .doc(UserModel().id)
            .update(updatelist);
      }
    });
  }

  void togglePlanner(DateTime date) async {
    List<Planner> plannerList = [];
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    final db = FirebaseFirestore.instance;

    Planner plannerObj =
        new Planner(date: formattedDate, poi: widget.poimodel.id!);

    await db
        .collection("Planner")
        .add(plannerObj.toFirestore())
        .then((value) async {
      await db.collection("Account").doc(UserModel.getUser().id).update({
        "planner": FieldValue.arrayUnion([value.id])
      });
      UserModel.getUser().planner!.add(value.id);
    });
  }

  void togglePlannerButton() async {
    final db = FirebaseFirestore.instance;
    var planner = await db
        .collection("Planner")
        .where(FieldPath.documentId, whereIn: UserModel.getUser().planner)
        .get();

    planner.docs.forEach((element) {
      if (element['poi'].toString() == widget.poimodel.id) {
        togglePlannerButtonColor = true;
      }
    });
  }

  toggleDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    setState(() {
      if (pickedDate == null) return;

      if (pickedDate.isBefore(DateTime.now().subtract(new Duration(days: 1)))) {
        Fluttertoast.showToast(
            msg: "Please select a date later than today.",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1);
        return;
      }

      if (pickedDate != null) {
        togglePlanner(pickedDate);
        Fluttertoast.showToast(
            msg: "Added Place of Interest into Itinerary Planner!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1);
        togglePlannerButton();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    togglePlannerButton();
    return Scaffold(
      extendBodyBehindAppBar: true,
      //TOP BUTTONS
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NavBar(
                      currentIndex: widget.currentIndex,
                    )),
            ModalRoute.withName('/welcome'),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 400,
                  child: Image.network(widget.poimodel.photourl,
                      fit: BoxFit.fill),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(widget.poimodel.name,
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                )
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
                          iconSize: 35,
                          onPressed: _toggleFavorite,
                          icon: (UserModel.getUser()
                                  .toJson()['favourites']
                                  .contains(widget.poimodel.id)
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border,
                                  color: Colors.grey)),
                        ),
                        IconButton(
                          onPressed: toggleDatePicker,
                          icon: Icon(Icons.playlist_add, color: Colors.grey),
                          // togglePlannerButtonColor
                          //     ? Icon(Icons.list_alt, color: Colors.blue)
                          //     : Icon(Icons.list, color: Colors.grey),
                          iconSize: 35,
                        ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                              halfFilledIconData:
                                                  Icons.star_half,
                                              defaultIconData:
                                                  Icons.star_border,
                                              starCount: 5,
                                              allowHalfRating: true,
                                              spacing: 2.0,
                                              size: 20.0);
                                        }
                                        return Container();
                                      })),
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
