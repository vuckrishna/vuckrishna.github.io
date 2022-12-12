// login page
import 'package:flutter/material.dart';
import 'package:sgtours/pages/welcome/BOsigntesttest.dart';
import 'signupBO.dart';
import 'signupM.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgtours/model/userModel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginPageState();
  //Widget build(BuildContext context) {}
}

class LoginPageState extends State<Login> {
  final db = FirebaseFirestore.instance;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    // Signin Function
    void signIn(String email, String password) async {
      if (_key.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        User? user = FirebaseAuth.instance.currentUser;

        FirebaseFirestore.instance
            .collection('Account')
            .doc(user!.uid)
            .get()
            .then((value) {
          UserModel obj = UserModel.fromJson(user.uid, value.data()!);
          UserModel.setUser(obj);


            if (value['role'] == 'admin') {
              Fluttertoast.showToast(
                  msg: "Admin Login Successful",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1);
              Navigator.of(context).pushReplacementNamed('/admin/home');
            }

            if ((value['role'] == 'user' || value['role'] == 'LOL') &&
                (value['accState'] == 'active' ||
                    value['accState'] == 'Pend(LOL)')) {
              if (user.emailVerified) {
                Fluttertoast.showToast(
                    msg: "Login Successful",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1);
                Navigator.of(context).pushReplacementNamed('/home');
              } else {
                Fluttertoast.showToast(
                    msg: "Account not verified",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1);

                FirebaseAuth.instance.signOut();
              }
            }

            if (value['role'] == 'BO' && value['accState'] == 'active') {
              Fluttertoast.showToast(
                  msg: "Login Successful",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1);
              Navigator.of(context).pushReplacementNamed('/BO/home');
            }
        
        });
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackGroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/images/sgtourlogo.PNG'),
                  SizedBox(height: 25),
                  Text(
                    'Hello!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to SGTours',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 50),

                  // email text Field
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

                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // password text field
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
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Center(
                      child: ElevatedButton(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          signIn(
                              _emailController.text, _passwordController.text);
                          // String path = '';
                          // switch (_emailController.text) {
                          //   case 'admin':
                          //     path = '/admin/home';
                          //     break;
                          //   case 'business':
                          //     path = '/BO/home';
                          //     break;
                          //   default:
                          //     path = '/home';
                          //     break;
                          // }
                          // Navigator.pushNamed(
                          //   context,
                          //   path,
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: kButtonColor, minimumSize: Size(320, 50)),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  // REGISTER AS MEMBER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a Member? '),
                      GestureDetector(
                        child: Text(
                          'Register ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Route page to signup page as a member upon clicking highlighted text
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => SignupM()));
                        },
                      ),
                      Text('with us now!'),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Own a Business? '),
                      SizedBox(height: 15),
                      GestureDetector(
                        child: Text(
                          'Onboard ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Route page to signup page as a business owner upon clicking highlighted text
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              //searchPage
                              //builder: (BuildContext context) => searchPage()));
                              builder: (BuildContext context) =>
                                  SignupBOtest()));

                          //builder: (BuildContext context) => SignupBO()));
                        },
                      ),
                      Text('to promote your business with us'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
