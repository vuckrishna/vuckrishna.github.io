import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgtours/pages/user/essentials/essentials.dart';
import 'package:sgtours/pages/welcome/login.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/ES_Feedback.dart';
import 'package:sgtours/model/userModel.dart';

bool checked = false;

class feedbackPage extends StatefulWidget {
  const feedbackPage({Key? key}) : super(key: key);

  @override
  _feedbackPage createState() => _feedbackPage();
}

class _feedbackPage extends State<feedbackPage> {
  final _key = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController residencyController = TextEditingController();
  TextEditingController feedbacktypeController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  final db = FirebaseFirestore.instance;

  void addFeedback(String name, String email, String contact, String residency,
      String feedbacktype, String subject, String feedback) async {
    ESfeedback feedbackObj = ESfeedback(
        name: name,
        feedbackState: 'Unread',
        email: email,
        contact: contact,
        residency: residency,
        feedbacktype: feedbacktype,
        subject: subject,
        feedback: feedback);

    await db.collection("ESFeedback").add(feedbackObj.toFirestore());
  }

//intiate selected value
  String dropdownvalue = 'Select Option';
  // List of items in our dropdown menu
  //to fetch API in future for list of Countries

  String dropdownvalue1 = 'Select Option';

  var typeOfFB = [
    'Feedback',
    'Complaint',
    'Suggestions',
    'Compliments',
    'Select Option'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Submit Feedback'),
        ),
        backgroundColor: kBackGroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    'Name:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(UserModel.getUser().toJson()['name'],
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 5.0),
                  SizedBox(height: 5.0),
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(UserModel.getUser().toJson()['email'],
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 5.0),
                  SizedBox(height: 5.0),
                  Text(
                    'Contact Number:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: contactController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contact number cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter contact number here',
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text('Feedback',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 40),
                    child: Container(
                      child: DropdownButton(
                        isExpanded: true,
                        // Initial Value
                        value: dropdownvalue1,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: typeOfFB.map((String typeOfFB) {
                          return DropdownMenuItem(
                            value: typeOfFB,
                            child: Text(typeOfFB),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue1 = newValue!;
                            feedbacktypeController.text = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Subject',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: subjectController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Subject Title cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter subject here',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Feedback',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  TextFormField(
                    controller: feedbackController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter description of feedback here',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            primary: Colors.red,
                          ),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              if (dropdownvalue1 != "Select Option") {
                                addFeedback(
                                    UserModel.getUser().toJson()['name'],
                                    UserModel.getUser().toJson()['email'],
                                    contactController.text,
                                    UserModel.getUser().toJson()['residency'],
                                    feedbacktypeController.text,
                                    subjectController.text,
                                    feedbackController.text);

                                Fluttertoast.showToast(
                                    msg: "Feedback Submitted!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);

                                Navigator.pushReplacementNamed(
                                    context, '/essentials');
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please select a feedback option",
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);
                              }
                            }
                          }),
                      SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
