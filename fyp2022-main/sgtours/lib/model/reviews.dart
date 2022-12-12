import 'package:flutter/material.dart';


class Reviewz {
  String name;
  String review;
  String url;
  Widget? page;

  Reviewz(this.name, this.review, this.url, this.page);
}

   List<Reviewz> ReviewList = [
      Reviewz('Harry', 'Lorum Ipsum Comment Lorem Ipsum Comment Lorem Ipsum Comment','lib/images/harrypotter.jpg', null),
      Reviewz('Snape', 'Lorum Ipsum Comment Lorem Ipsum Comment Lorem Ipsum Comment', 'lib/images/snape.jpg', null),
      Reviewz('Ron', 'Lorum Ipsum Comment Lorem Ipsum Comment Lorem Ipsum Comment', 'lib/images/ron.jpg', null),
      Reviewz('Harry', 'Lorum Ipsum Comment Lorem Ipsum Comment Lorem Ipsum Comment','lib/images/harrypotter.jpg', null)
    ];
  
