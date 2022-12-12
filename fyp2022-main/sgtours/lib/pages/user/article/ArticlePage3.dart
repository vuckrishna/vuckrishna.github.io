import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePage3 extends StatefulWidget {
  ArticlePage3({Key? key}) : super(key: key);

  @override
  State<ArticlePage3> createState() => _ArticlePage3State();
}

class _ArticlePage3State extends State<ArticlePage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TOP BUTTONS
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            //child: GestureDetector(onTap: () {}, child: Icon(Icons.share)),
            child: IconButton(
                icon: Icon(Icons.share), 
                onPressed: () {Share.share("suppose to put our app url or mbs homepage url?");
                },
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //ARTICLE TITLE CONTAINER
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Sustainable Produce From This Farm In Queenstown',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Text('Esther Chan'),
                Text('April 19, 2019')
              ],
            )),

            //ARTICLE CONTENT
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/images/cf1.jpg'),
                          fit: BoxFit.fill))),
                  Text(
                      '\nThis is not the typical farm you visit to feed and pet animals. Instead, Citizen Farm Singapore grows sustainable and pesticide-free vegetables which are sold to local restaurants. \n'),
                  Text(
                    'Citizen Farm',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/images/cf2.jpg'),
                          fit: BoxFit.fill))),
                  Text(
                      'Tucked away in Queenstown, the farm utilises advanced farming systems to produce vegetables that wouldn’t be able to thrive in Singapore’s warm and humid climate under normal circumstances. \n'),
                  Text(
                      'Some of the vegetables grown there include: Kale (a well-known superfood), Rainbow Chard and Microgreens like Sugar Snap Peas. \n'),
                  Text(
                    'Farm Tours',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/images/cf3.jpg'),
                          fit: BoxFit.fill))),
                  Text(
                      'Like other farms, Citizen Farm also conducts farm tours to allow people to get to know more about urban farming. \n'),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
