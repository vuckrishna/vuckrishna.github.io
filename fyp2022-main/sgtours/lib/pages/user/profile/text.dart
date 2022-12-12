import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/profile/LOLVerification.dart';
import 'package:sgtours/model/userModel.dart';
import 'edit_profile.dart';
import 'constant.dart';
import 'button.dart';
import 'dart:io' as file1;

class WelcomeText extends StatefulWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  late final UserModel user;

  final db = FirebaseFirestore.instance;

  var name;
  var username;
  var residency;
  var photourl;

  User? user1 = FirebaseAuth.instance.currentUser;
  //userId: user1.id!;
  PlatformFile? pickedFile;
  Future uploadFile() async {
    final path = 'profilepic/${pickedFile!.name}';
    photourl = path;
    final file = file1.File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    editPhotoUrl(path, user1!.uid);
    setState(() {});
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Account')
        .doc(user1!.uid)
        .get()
        .then((value) {
      name = value['name'];
      username = value['username'];
      residency = value['residency'];
      photourl = value['photourl'];
      setState(() {});
    });
    super.initState();
  }

  Future<String> getImage(String? photourl) async {
    final db = FirebaseStorage.instance;
    return await db.ref(photourl).getDownloadURL();
  }

  void editName(String name, String? id) async {
    this.name = name;
    await db.collection("Account").doc(id!).update({"name": name});
    setState(() {});
  }

  void editPhotoUrl(String photoUrl, String? id) async {
    await db.collection("Account").doc(id!).update({"photourl": photoUrl});
    if (UserModel.getUser().role == "LOL") {
      var guides =
          await db.collection("Guides").where("authorId", isEqualTo: id).get();
      var guideId = guides.docs.first.id;
      await db.collection("Guides").doc(guideId).update({"imageUrl": photoUrl});
    }
    setState(() {});
  }

  void editUsername(String username, String? id) async {
    await db.collection("Account").doc(id!).update({"username": username});
    setState(() {});
  }

  void editPlace(String residency, String? id) async {
    await db.collection("Account").doc(id!).update({"residency": residency});
    setState(() {});
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
    return Container(
      padding: EdgeInsets.only(top: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // new GestureDetector(
          //   onTap: selectFile,
          //   child: Container(
          // height: 180,
          // child: ClipRRect(
          //     borderRadius: BorderRadius.all(Radius.circular(30)),
          //     child: Image.asset(
          //       'lib/images/ron.jpg',
          //       fit: BoxFit.cover,
          //     ))),
          //     /*Image.file(
          //       file1.File(pickedFile!.path!),
          //       */
          // ),
          FutureBuilder(
              future: getImage(photourl),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data!),
                            fit: BoxFit.contain)),
                  );
                }
                return Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                        child: Text("No Profile Picture",
                            style: TextStyle(fontWeight: FontWeight.bold))));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  alignment: Alignment.centerRight,
                  onPressed: selectFile),
              IconButton(
                  icon: Icon(Icons.change_circle, color: Colors.black),
                  alignment: Alignment.centerRight,
                  onPressed: uploadFile),
            ],
          ),

          Text(
            "Profile Information",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: kTextColor),
          ),
          SizedBox(height: 10.0),
          Text(
            "Name:",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: kTextColor),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('$name',
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              alignment: Alignment.centerRight,
              onPressed: () async {
                TextEditingController editController =
                    TextEditingController(text: '$name');
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Edit Name'),
                    content: TextField(
                      controller: editController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //labelText: 'Name',
                        alignLabelWithHint: true,
                        isDense: true,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            editName(editController.text, '${user1!.uid}');
                            Navigator.pop(context);
                            editController.clear();
                          });
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ).then((value) => editController.clear());
              },
            ),
          ]),
          Text(
            "Username:",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: kTextColor),
          ),
          SizedBox(height: 10),
          Text('$username', style: TextStyle(fontSize: 18)),
          // IconButton(
          //   icon: Icon(Icons.edit, color: Colors.black),
          //   alignment: Alignment.centerRight,
          //   onPressed: () async {
          //     TextEditingController editController =
          //         TextEditingController(text: '$username');
          //     showDialog<String>(
          //       context: context,
          //       builder: (BuildContext context) => AlertDialog(
          //         title: const Text('Edit Username'),
          //         content: TextField(
          //           controller: editController,
          //           cursorColor: Colors.red,
          //           decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             //labelText: 'Username',
          //             alignLabelWithHint: true,
          //             isDense: true,
          //           ),
          //         ),
          //         actions: <Widget>[
          //           TextButton(
          //             onPressed: () async {
          //               editUsername(editController.text, '${user1!.uid}');
          //               Navigator.pop(context);
          //               editController.clear();
          //             },
          //             child: const Text('Submit'),
          //           ),
          //         ],
          //       ),
          //     ).then((value) => editController.clear());
          //     setState(() {});
          //   },
          // ),
          SizedBox(height: 10),
          Text(
            "Password:",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: kTextColor),
          ),
          Text('············', style: TextStyle(fontSize: 30)),
          SizedBox(height: 5.0),
          // Text(
          //   "Placce of Residency:",
          //   style: TextStyle(
          //       fontSize: 20, fontWeight: FontWeight.w700, color: kTextColor),
          // ),
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   Text('$residency', style: TextStyle(fontSize: 18)),
          //   IconButton(
          //     icon: Icon(Icons.edit, color: Colors.black),
          //     alignment: Alignment.centerRight,
          //     onPressed: () async {
          //       TextEditingController editController =
          //           TextEditingController(text: '$residency');
          //       showDialog<String>(
          //         context: context,
          //         builder: (BuildContext context) => AlertDialog(
          //           title: const Text('Edit Place'),
          //           content: TextField(
          //             controller: editController,
          //             cursorColor: Colors.red,
          //             decoration: InputDecoration(
          //               border: OutlineInputBorder(),
          //               //labelText: 'Username',
          //               alignLabelWithHint: true,
          //               isDense: true,
          //             ),
          //           ),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () async {
          //                 editPlace(editController.text, '${user1!.uid}');
          //                 Navigator.pop(context);
          //                 editController.clear();
          //               },
          //               child: const Text('Submit'),
          //             ),
          //           ],
          //         ),
          //       ).then((value) => editController.clear());
          //       setState(() {});
          //     },
          //   ),
          // ]),
          Visibility(
            visible: UserModel.getUser().role == "LOL" ? false : true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Want to verify yourself as LOL? '),
                GestureDetector(
                  child: Text(
                    'Verify Here',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Route page to signup page as a member upon clicking highlighted text
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LOLVerification()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          /*
          WelcomeButton(
            tapEvent: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editprofile()));
                  
            },
          )*/
        ],
      ),
    );
  }
}
