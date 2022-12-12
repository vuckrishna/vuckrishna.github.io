//sign up page for business owner
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgtours/pages/welcome/constant.dart';
import 'package:sgtours/AuthenticationService.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/pages/welcome/login.dart';
import 'login.dart';

class SignupBOtest extends StatefulWidget {
  const SignupBOtest({Key? key}) : super(key: key);

  @override
  _SignupBOtest createState() => _SignupBOtest();
}

class _SignupBOtest extends State<SignupBOtest> {
  //Authentication Services
  final _key = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();

  final db = FirebaseFirestore.instance;

  /*Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
  }

  Future uploadFile() async {}*/

// we have initialized active step to 0 so that
// our stepper widget will start from first step
  int _activeCurrentStep = 0;
  bool isCompleted = false;
  bool hide = true;

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  TextEditingController uen = TextEditingController();
  TextEditingController snric = TextEditingController();
  TextEditingController companyadd = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController ACRA = TextEditingController();

// Here we have created list of steps
// that are required to complete the form
  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          // isActive: true,
          title: const Text('Account'),
          content: Form(
            key: _key,
            //key: formKeys[0],
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Business Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: desc,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Description',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: companyadd,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Address',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: email,
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: pass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: confirmpass,
                  validator: (value) {
                    if (value == null || value.isEmpty || value != pass.text) {
                      return 'Password cannot be empty/Does not match';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: uen,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'UEN cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UEN',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: snric,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 9) {
                      return 'NRIC cannot be empty/incorrect format';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Signee NRIC',
                  ),
                ),
              ],
            ),
          ),
        ),
        // This is Step2 here
        Step(
          state:
              _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 1,
          title: const Text('Others'),
          content: Form(
              //key: formKeys[1],
              // key: _key,
              child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: website,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Website',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: ACRA,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'acra cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ACRA',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                /*ElevatedButton(
                  child: const Text(
                    'Upload Certificate of Incorporation',
                  ),
                  onPressed: selectFile,
                  style: ElevatedButton.styleFrom(primary: kButtonColor),
                ),*/
              ],
              //upload
            ),
          )),
        ),
        // This is Step3 here we will display all the details
        // that are entered by the user
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: const Text('Confirm'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(name.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Description: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(desc.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(email.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("UEN: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(uen.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Company Address: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(companyadd.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Website: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(website.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ACRA: "),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(ACRA.text),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () {
                        //if (formKeys[_activeCurrentStep].currentState!.validate())
                        if (_key.currentState!.validate()) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: pass.text)
                              .then((value) {
                                FirebaseFirestore.instance
                                    .collection('Account')
                                    .doc(value.user!.uid)
                                    .set({
                                  "email": value.user!.email,
                                  "role": 'BO',
                                  "name": name.text,
                                  "desc": desc.text,
                                  "address": companyadd.text,
                                  "uen": uen.text,
                                  "nric": snric.text,
                                  "web": website.text,
                                  "accState": 'Pend(BO)',
                                });
                              })
                              .then(
                                (value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                ),
                              )
                              .onError((error, stackTrace) {
                                print('Error ${error.toString()}');
                              });

                          Fluttertoast.showToast(
                              msg: "Business Account Successfully Registered",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1);
                        }
                      },
                    )),
              ],
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          'Register for Business Owner',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // Here we have initialized the stepper widget
      body: Stepper(
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          return Row(
            children: <Widget>[
              Visibility(
                visible: hide,
                child: ElevatedButton(
                  onPressed: dtl.onStepContinue,
                  child: Text('CONTINUE'),
                ),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: dtl.onStepCancel,
                child: Text('CANCEL'),
              ),
            ],
          );
        },
        type: StepperType.horizontal,
        currentStep: _activeCurrentStep,
        steps: stepList(),

        // onStepContinue takes us to the next step
        onStepContinue: () {
          //  if (formKeys[_activeCurrentStep].currentState!.validate())
          if (_key.currentState!.validate()) {
            if (_activeCurrentStep < (stepList().length - 1)) {
              setState(() {
                _activeCurrentStep += 1;
                if (_activeCurrentStep == 2)
                  hide = false;
                else
                  hide = true;
              });
            }
          }
        },

        // onStepCancel takes us to the previous step
        onStepCancel: () {
          if (_activeCurrentStep == 0) {
            Navigator.pop(context);
            return;
          }

          setState(() {
            _activeCurrentStep -= 1;
            if (_activeCurrentStep == 2)
              hide = false;
            else
              hide = true;
          });
        },

        // onStepTap allows to directly click on the particular step we want
        // onStepTapped: (int index) {
        //   setState(() {
        //     _activeCurrentStep = index;
        //   });
        // },
      ),
    );
  }
}
