import 'dart:io' as file1;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/Verify_Lol.dart';
import 'package:sgtours/pages/user/profile/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool checked = false;

class LOLVerification extends StatefulWidget {
  LOLVerification({Key? key}) : super(key: key);

  @override
  State<LOLVerification> createState() => _LOLVerificationState();
}

class _LOLVerificationState extends State<LOLVerification> {
  final _key = GlobalKey<FormState>();
  late final UserModel user;

  TextEditingController legalnameController = TextEditingController();
  TextEditingController handleController = TextEditingController();
  final db = FirebaseFirestore.instance;
  User? userid = FirebaseAuth.instance.currentUser;

  PlatformFile? pickedFile;
  String pickedFilePath = "";

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = file1.File(pickedFile!.path!);
    pickedFilePath = path;

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

    Fluttertoast.showToast(
        msg: "Image has been uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Account')
        .doc(userid!.uid)
        .get()
        .then((value) {
      setState(() {});
    });
    super.initState();
  }

  void addVerification(String fullLegalName, String handle) async {
    VerifyLol verifylolObj = VerifyLol(
        fullLegalName: fullLegalName, handle: handle, imageurl: pickedFilePath);

    await db
        .collection("VerifyLOL")
        .add(verifylolObj.toFirestore())
        .then((value) async {
      verifylolObj.id = value.id;
      await db.collection("Account").doc(userid?.uid).update(
          {"accState": "Pend(LOL)", "verifyDocumentID": verifylolObj.id});
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Verification'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Verify yourself as a Local Opinion Leader!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //TEXTINPUT
                Form(
                  key: _key,
                  child: Column(
                    children: [
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
                                controller: legalnameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Full Legal Name cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Full Legal Name',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                controller: handleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Brand Name/Social Media Handle cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Brand Name/Social Media Handle',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // UPLOAD FILE WIDGET
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text(
                            'Upload Government-issued ID',
                          ),
                          onPressed: selectFile,
                          style:
                              ElevatedButton.styleFrom(primary: kButtonColor),
                        ),
                      ]),
                ),
                SizedBox(height: 10),

                //CHECKBOX
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                                "I hereby declare that all information provided is true and accurate.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          Checkbox(
                            value: checked,
                            onChanged: (changedValue) {
                              setState(() {
                                checked = changedValue!;
                              });
                            },
                            activeColor: Colors.red,
                            checkColor: Colors.black,
                          )
                        ]),
                  ),
                ),
                const SizedBox(height: 10),

                //SUBMIT BUTTON
                ElevatedButton(
                  child: const Text(
                    'Submit',
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      if (checked) {
                        await uploadFile();
                        if (pickedFilePath.isNotEmpty) {
                          addVerification(
                              legalnameController.text, handleController.text);
                          Navigator.of(context).pop('/profile');
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please upload image",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Please agree to that all information provided is correct",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kButtonColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                )
              ],
            ),
          ),
        ));
  }
}
