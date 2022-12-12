import 'package:flutter/material.dart';

class Essentials extends StatefulWidget {
  @override
  State<Essentials> createState() => _EssentialsState();
}

class _EssentialsState extends State<Essentials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Text(
          'Essentials',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      side: BorderSide(color: Colors.deepOrange),
                      fixedSize: Size(130, 130),
                    ),
                    child:
                        Text('Currency Converter', textAlign: TextAlign.center),
                    onPressed: () => {Navigator.pushNamed(context, '/essentials/currencyConverter/currencyconverterpage')},
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      side: BorderSide(color: Colors.deepOrange),
                      fixedSize: Size(130, 130),
                    ),
                    child:
                        Text('Emergency Contact', textAlign: TextAlign.center),
                    onPressed: () => {Navigator.pushNamed(context, '/essentials/emergencycontact')},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      side: BorderSide(color: Colors.deepOrange),
                      fixedSize: Size(130, 130),
                    ),
                    child: Text('About', textAlign: TextAlign.center),
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/essentials/about')},
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      side: BorderSide(color: Colors.deepOrange),
                      fixedSize: Size(130, 130),
                    ),
                    child: Text('Tips', textAlign: TextAlign.center),
                    onPressed: () => {Navigator.pushNamed(context, '/essentials/tips')},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      side: BorderSide(color: Colors.deepOrange),
                      fixedSize: Size(130, 130),
                    ),
                    child: Text('FAQs', textAlign: TextAlign.center),
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/essentials/faqs')},
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      side: BorderSide(color: Colors.deepOrange),
                      fixedSize: Size(130, 130),
                    ),
                    child: Text('Submit Feedback', textAlign: TextAlign.center),
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/essentials/feedback')},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
