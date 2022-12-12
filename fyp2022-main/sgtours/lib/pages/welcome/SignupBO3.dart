//confirmation page for business owner
import 'package:flutter/material.dart';
import 'package:sgtours/pages/welcome/login.dart';
import 'package:sgtours/pages/welcome/constant.dart';

bool checked = false;

class SignupBO3 extends StatefulWidget {
  const SignupBO3({Key? key}) : super(key: key);

  @override
  _SignupBO3 createState() => _SignupBO3();
}

class _SignupBO3 extends State<SignupBO3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Create a Business Account'),
        ),
        backgroundColor: kBackGroundColor,
        // body: SafeArea(
        //all the fetched data here

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Business Entity Name:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Lorem Ipsum Name'),
                SizedBox(height: 20.0),
                Text('UEN:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Lorem Ipsum UEN'),
                SizedBox(height: 20.0),
                Text('Contract Signee Name:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Lorem Ipsum Name'),
                SizedBox(height: 20.0),
                Text('Contract Signee NRIC:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('S1234567Z'),
                SizedBox(height: 20.0),
                Text('Email Address:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('LoremIpsum@Email.com'),
                SizedBox(height: 20.0),
                Text('Company Address:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Lorem Ipsum Address'),
                SizedBox(height: 20.0),
                Text('Company Description',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Lorem Ipsum Description'),
                SizedBox(height: 20.0),
                Text('Company Website',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('www.loremipsum.com'),
                SizedBox(height: 30.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                      "I hereby declare that all information provided\n is true and accurate.",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: kButtonColor),
                          width: 200,
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
