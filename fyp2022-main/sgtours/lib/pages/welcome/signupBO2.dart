//2nd sign up page for business owner
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'BO_button.dart';
import 'SignupBO3.dart';
import 'package:sgtours/pages/welcome/constant.dart';

bool checked = false;

class SignupBO2 extends StatefulWidget {
  const SignupBO2({Key? key}) : super(key: key);

  @override
  _SignupBO2 createState() => _SignupBO2();
}

class _SignupBO2 extends State<SignupBO2> {
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
  }

  Future uploadFile() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text('Create a Business Account'),
        ),
        backgroundColor: kBackGroundColor,
        // body: SafeArea(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Sign in Here if you have an existing account!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 50),
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
                        child: TextField(
                          maxLines: 8,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Company Description',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // website
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
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Company Website',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // upload files goes here

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text(
                            'Upload Certificate of Incorporation',
                          ),
                          onPressed: selectFile,
                          style:
                              ElevatedButton.styleFrom(primary: kButtonColor),
                        ),
                      ]),
                ),
                SizedBox(height: 20),
                // check box here

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
                const SizedBox(height: 10),

                //submit button
                BONextButton(tapEvent: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupBO3()));
                })
              ],
            ),
          ),
        ));
  }
}
