import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectAndUploadButton extends StatefulWidget {
  static String? filePath;
  const SelectAndUploadButton({Key? key}) : super(key: key);

  @override
  State<SelectAndUploadButton> createState() => _SelectAndUploadButtonState();
}

class _SelectAndUploadButtonState extends State<SelectAndUploadButton> {
  static PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'images/${pickedFile!.name}';
    SelectAndUploadButton.filePath = path;
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

    Fluttertoast.showToast(
        msg: "Image Uploaded Successfully",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await selectFile();
          await uploadFile();
        },
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          primary: Colors.red,
        ),
        child: const Text('Upload Image'));
  }
}
