import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      /*
      child: Container(
          height: 180,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                'lib/images/ron.jpg',
                fit: BoxFit.cover,
              ))),
              */
    );
  }
}
