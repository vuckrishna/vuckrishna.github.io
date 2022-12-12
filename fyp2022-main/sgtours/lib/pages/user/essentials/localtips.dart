import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class LocalTips extends StatefulWidget {
  @override
  State<LocalTips> createState() => _LocalTipsState();
}

class _LocalTipsState extends State<LocalTips> {
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
            title: Text('Local Tips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ))),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            ExpansionTileCard(
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardA,
              title: Text("Local Quirks",
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
                        "Chope." +
                            "This common local term means to reserve a place of call dibs on something. If you see a pack of tissues on a seat or table during lunch time at a hawker centre, the spot has been choped!",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
              ],
            ),
            ExpansionTileCard(
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardB,
              title: Text("Singlish",
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
                    child: Text("Tapao: The Singlish equivalent of takeaway.",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
