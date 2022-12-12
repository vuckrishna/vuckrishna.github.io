// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/pages/welcome/login.dart';

class Admin_Homepage extends StatefulWidget {
  const Admin_Homepage({Key? key}) : super(key: key);

  @override
  State<Admin_Homepage> createState() => _Admin_HomepageState();
}

class _Admin_HomepageState extends State<Admin_Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Admin Homepage',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            )),
        actions: [
          PopupMenuButton(
              onSelected: (result) {
                if (result == 0) {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()),
                        ),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, '/admin/request/account');
                }),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Text('Account Requests',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, '/admin/request/article');
                }),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Text('Article Requests',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, '/admin/request/guide');
                }),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Text('Itinerary Guide Requests',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, '/admin/request/feedbacks');
                }),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Text('View Feedbacks',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
