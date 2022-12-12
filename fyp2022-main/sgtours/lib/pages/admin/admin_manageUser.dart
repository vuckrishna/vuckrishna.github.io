// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sgtours/model/userModel.dart';
import 'package:sgtours/pages/admin/admin_manageIndividualUser.dart';

class Admin_ManageUser extends StatefulWidget {
  const Admin_ManageUser({Key? key}) : super(key: key);

  @override
  State<Admin_ManageUser> createState() => _Admin_ManageUserState();
}

class _Admin_ManageUserState extends State<Admin_ManageUser> {
  static TextEditingController _searchController = TextEditingController();
  String searchText = '';

  static Future<List<UserModel>> getUser() async {
    List<UserModel> userList = [];
    final db = FirebaseFirestore.instance;

    var allUser = await db
        .collection("Account")
        .where('role', whereIn: ['user', 'LOL', 'BO']).get();

    allUser.docs.forEach((e) {
      if (e
          .data()["username"]
          .toString()
          .toUpperCase()
          .contains(_searchController.text.toUpperCase())) {
        userList.add(UserModel.fromJson(e.id, e.data()));
      }
    });

    return userList;
  }

  Future<String> getImage(String imageUrl) async {
    final db = FirebaseStorage.instance;
    return await db.ref(imageUrl).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Manage User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Username...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future: getUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<UserModel> data = snapshot.data;
                    return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 3),
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      admin_manageIndividualUser(
                                          userEmail: data[index].email!)),
                                ),
                              );
                            },
                            child: Card(
                              child: Row(children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    child: FutureBuilder(
                                      future: data[index].photourl == null ||
                                              data[index].photourl == ''
                                          ? getImage('profilepic/noimg.png')
                                          : getImage(data[index].photourl!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            child: Image.network(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }

                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name!, style: TextStyle(
                                                fontWeight: FontWeight.w900),),
                                        Text(data[index].role!),
                                        Text(data[index].email!),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ));
  }
}
