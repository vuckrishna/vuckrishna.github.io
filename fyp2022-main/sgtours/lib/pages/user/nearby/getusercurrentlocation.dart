import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserCurrentLocation extends StatefulWidget {

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {

  var locationMessage = "";

  void getCurrentPosition() async {
    var permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastposition = await Geolocator.getLastKnownPosition();

    var lat = position.latitude;
    var long = position.longitude;

    print("$lat, $long");

    setState(() {
      locationMessage = "$position"; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Current Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
          ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 46.0,
              color: Colors.blue,
            ),
            SizedBox(height: 10.0,),
            Text("Get user location", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0,),
            Text(locationMessage),
            FlatButton(onPressed: (){
              getCurrentPosition();
            },
              color: Colors.blue[800],
              child: Text("Get current location", style: TextStyle(color: Colors.white,)),
            )
          ],
        )
      );
  }
}
