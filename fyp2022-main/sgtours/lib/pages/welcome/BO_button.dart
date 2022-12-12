import 'package:flutter/material.dart';
import 'package:sgtours/pages/welcome/constant.dart';

class BONextButton extends StatelessWidget {
  const BONextButton({Key? key, required this.tapEvent}) : super(key: key);

  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: tapEvent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: kButtonColor),
          width: 200,
          height: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
        ));
  }
}
