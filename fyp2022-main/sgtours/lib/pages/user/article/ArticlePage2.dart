import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePage2 extends StatefulWidget {
  ArticlePage2({Key? key}) : super(key: key);

  @override
  State<ArticlePage2> createState() => _ArticlePage2State();
}

class _ArticlePage2State extends State<ArticlePage2> {
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
                    'F1 22: The Best Car Setup for Singapore (Marina Bay) Race',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Text('Pedro Sousa'),
                Text('July 16, 2022')
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
                          image: AssetImage('lib/images/f1sg.png'),
                          fit: BoxFit.fill))),
                  Text(
                      '\nF1 22 brings the latest iteration of the racing video game franchise to the next generation of consoles and PCs as it challenges players with difficult tracks, such as the Marina Bay circuit in the Singapore Grand Prix. F1 22 is the fifteenth entry to the Formula 1 game series and offers players a multitude of new additions as well as a visually stunning experience. This motorsport has gained great popularity in the last few years, most likely due to the success of the Netflix series, Drive to Survive, which focuses on the goings-on inside the paddock. \n'),
                  Text(
                      'To reflect the new Formula 1 World Championship\'s technical regulations that drastically impacted the look of a Formula 1 car, F1 22 features brand new card models with updated physics, completely changing the inner workings of car setups. Also added in F1 22 are Sprint Races, which function as a "mini-race" that occurs after Qualifying and determines the starting grid in the main race. Last but not least, several tracks have been modified to represent their new layouts, and a new one has been added, the F1 Miami Grand Prix. \n'),
                  Text(
                      'To become a champion in F1 22, having the proper car setup is more important than the drive itself. Each track on the calendar will present unique challenges that must be overcome by modifying the car accordingly. For example, having a high downforce is excellent for tracks with many winding corners, but too much of it can be detrimental in long straights, as the added drag will slow down the car. Balancing a vehicle for each Grand Prix is therefore crucial to success in F1 22 and something that players will need to master to become world champions. \n'),
                  Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/images/f1.jpg'),
                          fit: BoxFit.fill))),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
