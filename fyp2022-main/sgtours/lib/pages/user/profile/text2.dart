import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'constant.dart';
import 'button2.dart';
import 'profile.dart';


class WelcomeText2 extends StatelessWidget {
  const WelcomeText2({
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
            "Edit Profile Information",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w700, color: kTextColor),
          ),
              TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'James Bond',
                decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                color: Colors.red,
                ),
                ),
                ),
                TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'JamesBond2333',
                decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                color: Colors.red,
                ),
                ),
                ),
                TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'JamesBond',
                decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                color: Colors.red,
                ),
                ),
                ),
                TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'Singapore',
                decoration: InputDecoration(
                labelText: 'Place of residence',
                labelStyle: TextStyle(
                color: Colors.red,
                ),
                ),
                ),
          SizedBox(height: 40),
          WelcomeButton2(
            tapEvent: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          )
        ],
      ),
    );
  }
}
