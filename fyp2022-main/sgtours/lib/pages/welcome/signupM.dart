//sign up page for member
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/AuthenticationService.dart';
import 'login.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupM extends StatefulWidget {
  const SignupM({Key? key}) : super(key: key);

  @override
  _SignupM createState() => _SignupM();
}

class _SignupM extends State<SignupM> {
  //Authentication Services
  final _key = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

// set values for checkbox list
  List multiselect = [];
  List checkListItems = [
    {"id": 0, "value": true, "title": 'I agree to the T&C'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Sign Up As A Member'),
      ),
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: Center(
            child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Complete the form to signup and explore Singapore!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              // Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Email Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }

                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return "Please Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Address',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              //password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              //confirm password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _confirmpasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password cannot be empty';
                          }

                          if (value != _passwordController.text) {
                            return 'Password not match';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm password',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              //buttons for T&Cs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(
                        checkListItems.length,
                        (index) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            checkListItems[index]["title"],
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          value: checkListItems[index]["value"],
                          onChanged: (value) {
                            setState(() {
                              checkListItems[index]["value"] = value;
                              if (multiselect.contains(checkListItems[index])) {
                                multiselect.remove(checkListItems[index]);
                              } else {
                                multiselect.add(checkListItems[index]);
                              }
                            });
                          },
                          subtitle: !checkListItems[index]["value"]
                              ? Text(
                                  'Required.',
                                  style: TextStyle(color: Colors.red),
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: ElevatedButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        if (checkListItems.first["value"]) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text)
                              .then((value) {
                                FirebaseFirestore.instance
                                    .collection('Account')
                                    .doc(value.user!.uid)
                                    .set({
                                  "email": value.user!.email,
                                  "role": 'user',
                                  "name": _nameController.text,
                                  "username": _usernameController.text,
                                  "accState": 'active',
                                  "favourites": [],
                                  "planner": [],
                                  "photourl": '',
                                  "residency": '',
                                });

                                Fluttertoast.showToast(
                                    msg: 'Sign Up Success!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);

                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                    .then((value) =>
                                        value.user?.sendEmailVerification())
                                    .then((value) =>
                                        FirebaseAuth.instance.signOut());
                              })
                              .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  ))
                              .onError((error, stackTrace) {
                                Fluttertoast.showToast(
                                    msg: '$error',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);
                              });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please agree to the T&Cs",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: kButtonColor, minimumSize: Size(300, 50)),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
