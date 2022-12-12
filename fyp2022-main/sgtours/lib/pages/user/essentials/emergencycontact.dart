import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmergencyContact extends StatefulWidget {
  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {

    Future launchSPFNum() async {
      const spfnum = '999';
      await launchUrlString('tel:$spfnum');
    }

    Future launchSCDFNum() async {
      const scdfnum = '995';
      await launchUrlString('tel:$scdfnum');
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(
          'Emergency Contacts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Singapore Police Force',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('lib/images/spf.png', width: 250, height: 100,),
                RichText(
                  text: TextSpan(
                      text: 'Click here to call',
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = launchSPFNum,
                        ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Singapore Civil Defence Force',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('lib/images/scdf.png', width: 250, height: 100,),
                RichText(
                  text: TextSpan(
                      text: 'Click here to call',
                      style:
                          TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = launchSCDFNum,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
