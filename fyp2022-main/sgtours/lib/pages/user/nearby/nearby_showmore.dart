// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgtours/model/travel.dart';
import 'package:sgtours/pages/user/nearby/getusercurrentlocation.dart';
import 'package:sgtours/pages/user/poi/map_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sgtours/model/nearbyPlace.dart';
import 'dart:math';

class Nearby_ShowMore extends StatefulWidget {
  final String type;
  const Nearby_ShowMore({Key? key, required this.type}) : super(key: key);

  @override
  State<Nearby_ShowMore> createState() => _Nearby_ShowMoreState();
}

class _Nearby_ShowMoreState extends State<Nearby_ShowMore> {
  var lat;
  var long;

  Future<Point<double>> getCurrentPosition() async {
    var permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastposition = await Geolocator.getLastKnownPosition();
    return Point(position.latitude, position.longitude);
  }

  Future<List<NearbyPlace>> getNearbyLocation() async {
    Point<double> point = await getCurrentPosition();
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${point.x},${point.y}&radius=1500&type=${widget.type}&key=AIzaSyDVt-02Ix0eO76-Ng45VNbxFFDQGEy9Z3Q'));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<dynamic> results = responseBody["results"];
      List<NearbyPlace> nearbyPlacesList = [];

      for (var element in results) {
        nearbyPlacesList.add(NearbyPlace.fromJson(element));
      }

      return nearbyPlacesList;
    }

    throw Exception('Failed to load nearby places');
  }

  @override
  Widget build(BuildContext context) {
    Future<List<NearbyPlace>> data = getNearbyLocation();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('View Nearby Me',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: FutureBuilder<List<NearbyPlace>>(
            future: data,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      List<NearbyPlace>? data = snapshot.data;
                      return Card(
                          child: ListTile(
                        title: Expanded(child: Text(data![index].name)),
                        onTap: () {
                          MapUtils.openMap(data[index].lat, data[index].lat,
                              data[index].placeId);
                        },
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 0),
                    itemCount: snapshot.data!.length);
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
