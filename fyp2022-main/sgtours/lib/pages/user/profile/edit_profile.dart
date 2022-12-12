import 'package:flutter/material.dart';
import 'text2.dart';
import 'top_banner.dart';

class editprofile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [TopBanner(), WelcomeText2()],
          ),
        ),
      ),
    );
  }
}
