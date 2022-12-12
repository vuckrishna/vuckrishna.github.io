import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class AroundSg extends StatefulWidget {
  @override
  State<AroundSg> createState() => _AroundSgState();
}

class _AroundSgState extends State<AroundSg> {
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
            title: Text('Getting around SG',
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
              title: Text("By Train",
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
                        "Singapore's MRT (Mass Rapid Transit) system is probably the fastest way to get around the city. Most of our local attractions are of walking distance away, making it an excellent way of getting around.\n\n"
                                "Visitors may opt for the following options for their travel journey:\n \n" +
                            "1. Get a Singapore Tourist Pass (STP) \n\n" +
                            "2. You can use your foreign-issued Mastercard and Visa contactless bank cards issued outside of Singapore for payment of public transport fares in Singapore\n\n" +
                            "3. Adult Stored Value Smartcard (EZ-link/Nets FlashPay): These costs \$12 inclusive of a stored value of \$7 for you to use during your commute.",
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
              title: Text("By Bus",
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
                        "Singapore's bus system has an extensive network of routes covering most places.\n"
                        "Visitors can make use of their foreign-issued Mastercard and Visa contactless bank issued outside to pay for the ride, \n or using an adult stored value smartcard (Ezlink/ Nets Flashpay) or the Singapore Tourist Pass (STP).",
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
              title: Text("By Taxi",
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
                        "Taxis are comfortable and especially convenient if you are planning to visit places that are inaccessiblr via bus or mrt. Taxis here are metered, and there might be applicable surcharges depending on the location, timing and type of taxi you board.",
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
