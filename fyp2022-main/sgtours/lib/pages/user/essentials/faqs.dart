import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/profile/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class FAQS extends StatefulWidget {
  FAQS({Key? key}) : super(key: key);

  @override
  State<FAQS> createState() => _FAQSState();
}

class _FAQSState extends State<FAQS> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text('FAQs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ))),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                child: ListTile(
                    title: Text('General',
                        style: (TextStyle(fontWeight: FontWeight.bold))))),
            ExpansionTileCard(
              initialPadding: EdgeInsets.all(5.0),
              finalPadding: EdgeInsets.all(5.0),
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardA,
              title: Text("What is SGTours App for?",
                  style: (TextStyle(fontWeight: FontWeight.w400))),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                        "The SGTours app is designed to make your visit to Singapore convenient and enjoyable.",
                        //" creative and leading-edge flutter app development solutions for customers all around the globe.",
                        style: Theme.of(context).textTheme.bodyText2
                        //.copyWith(fontSize: 16),
                        ),
                  ),
                ),
              ],
            ),
            ExpansionTileCard(
              initialPadding: EdgeInsets.all(5.0),
              finalPadding: EdgeInsets.all(5.0),
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardB,
              title: Text("Can I provide feedback on the app?",
                  style: (TextStyle(fontWeight: FontWeight.w400))),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                        "Yes, we welcome all feedback to make our app better. For further enquires, contact us at 1800 0000 6666.",
                        //" creative and leading-edge flutter app development solutions for customers all around the globe.",
                        style: Theme.of(context).textTheme.bodyText2
                        //.copyWith(fontSize: 16),
                        ),
                  ),
                ),
              ],
            ),
            Card(
                child: ListTile(
                    title: Text('SG Arrival Card',
                        style: (TextStyle(fontWeight: FontWeight.bold))))),
            ExpansionTileCard(
              initialPadding: EdgeInsets.all(5.0),
              finalPadding: EdgeInsets.all(5.0),
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardC,
              title: Text("What is the SG Arrival card?",
                  style: (TextStyle(fontWeight: FontWeight.w400))),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                        "SG Arrival card is the electronic version of the paper disembarkation/embarkation (DE) card that forign visitors are currently required to submit on arrival.\nPlease note that the SG Arrival card is not a visa. The use of the SG Arrival card e-service is free of charge.",
                        //" creative and leading-edge flutter app development solutions for customers all around the globe.",
                        style: Theme.of(context).textTheme.bodyText2
                        //.copyWith(fontSize: 16),
                        ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
