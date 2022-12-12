import 'package:flutter/material.dart';
import 'package:sgtours/pages/user/essentials/usefulinfo.dart';


class Tips extends StatefulWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Tips',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ))),

              body:ListView(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          title: Text('Useful Information', textAlign: TextAlign.left),
                          trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: (){
                              Navigator.pushNamed(context, '/usefulinfo');},
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Local Tips', textAlign: TextAlign.left),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (){
                              Navigator.pushNamed(context, '/localtips');},
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Getting around Singapore', textAlign: TextAlign.left),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (){
                              Navigator.pushNamed(context, '/aroundsg');},
                        ),
                      ),
                    ],
                  )

    );
  }
}