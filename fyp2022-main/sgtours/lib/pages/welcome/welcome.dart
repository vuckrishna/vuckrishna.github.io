//welcome page here
// first page that user sees
import 'package:flutter/material.dart';
import 'welcome_text.dart';
import 'package:sgtours/pages/welcome/top_banner.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TopBanner(), WelcomeText()],
        ),
      ),
    );
  }
}
