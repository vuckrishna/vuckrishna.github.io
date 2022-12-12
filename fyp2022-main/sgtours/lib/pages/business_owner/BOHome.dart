import 'package:flutter/material.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/welcome/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BOHome extends StatefulWidget {
  BOHome({Key? key}) : super(key: key);

  @override
  State<BOHome> createState() => _BOHomeState();
}

class _BOHomeState extends State<BOHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.red,
            actions: [
              PopupMenuButton(
                  onSelected: (result) {
                    if (result == 0) {
                      FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Login())),
                          );
                    }
                  },
                  itemBuilder: ((context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Text('Logout'),
                            ],
                          ),
                        )
                      ]))
            ],
            title: Text('Business Owner Homepage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ))),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      'Welcome, ' +
                          UserModel.getUser().toJson()['name'].toString(),
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25)),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, '/BO/viewarticle');
                  }),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade200,
                          borderRadius: BorderRadius.circular(10),
                        )),
                    Text('View Own Articles',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, '/BO/createarticle');
                  }),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(10),
                        )),
                    Text('Create Articles',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, '/BO/deletearticle');
                  }),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade200,
                          borderRadius: BorderRadius.circular(10),
                        )),
                    Text('Pending Deletion of Articles',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
