import 'package:flutter/material.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'welcome_button.dart';
import 'package:sgtours/pages/welcome/login.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visit Singapore with \n" + "SGTours",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w700, color: kTextColor),
          ),
          SizedBox(height: 25),
          Text(
            'SGTours serves to provide the best experience for all your Singapore needs!',
            style: TextStyle(fontSize: 16, color: kTextColor),
          ),
          SizedBox(height: 40),
          WelcomeButton(
            tapEvent: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
    );
  }
}
