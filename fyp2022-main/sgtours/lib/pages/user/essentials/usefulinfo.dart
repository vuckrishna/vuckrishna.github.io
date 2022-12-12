import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class Usefulinfo extends StatefulWidget {
  @override
  State<Usefulinfo> createState() => _UsefulinfoState();
}

class _UsefulinfoState extends State<Usefulinfo> {
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
            title: Text('Useful Information',
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
              title: Text("Currency Used in Singapore",
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
                        "Singapore dollars are used here. Notes comes in denominations of \$2, \$5, \$10, \$50, \$100, \$1,000 and \$10,000. Coins comes in 5, 10, 20 and 50 cents and \$1.",
                        //" creative and leading-edge flutter app development solutions for customers all around the globe.",
                        style: Theme.of(context).textTheme.bodyText2
                        //.copyWith(fontSize: 16),
                        ),
                  ),
                ),
              ],
            ),
            ExpansionTileCard(
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardB,
              title: Text("Wifi Connectivity",
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
                        "Visitors can register for a free public Wi-Fi account with their foreign mobile numbers at any Wireless@SG hotspot. However, overseas charges may apply.",
                        //" creative and leading-edge flutter app development solutions for customers all around the globe.",
                        style: Theme.of(context).textTheme.bodyText2
                        //.copyWith(fontSize: 16),
                        ),
                  ),
                ),
              ],
            ),
            ExpansionTileCard(
              baseColor: Colors.white,
              expandedColor: Colors.white,
              key: cardC,
              title: Text("Languages used",
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
                        "English is the most common language used here, can be spoken to Singaporeans, whom most are fluent in it. Additionally, most Singaporeans speak an additional language, usually Mandarin Chinese, Malay or Tamil.",
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
