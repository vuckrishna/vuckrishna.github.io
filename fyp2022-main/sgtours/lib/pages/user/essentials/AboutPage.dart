import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('About Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ))),

              body:Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('About SGTours', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 30.0),
                      Text('Travelling and exploring new places has been a favourite pastime of many people. Before the widespread use of the internet and technology, many people referred to travel guides on TVs and guidebooks to check on the recommended places to visit in a country.'),
                      SizedBox(height: 15.0),
                      Text('With the widespread use of technology, there has been an increase in the number of user-generated content, blogs, videos, and information about various places of interest around the world. These user-generated contents allow users to read the different reviews of the places from people around the world. Many people have since then researched their itinerary and even booked flight tickets online.'),
                      SizedBox(height: 15.0),
                      Text('With the aim of SGTours as an encyclopedia about Singapore and its landmarks, we want our users to be able to readily access information and reviews at the touch of their fingertips, aiding them in the planning of their next trip to Singapore.'),
                    ],
                  ),
                )
              ),

    );
  }
}