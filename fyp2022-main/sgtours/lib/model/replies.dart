import 'package:flutter/material.dart';

class Replies {
  String author;
  String profileText;
  String userType;
  String timePosted;
  String comment;

  Replies(this.author, this.profileText, this.userType, this.timePosted,
      this.comment);
}

List<Replies> replyList = [
  Replies(
      'Christy', 'C', 'LOL', 'Today at 10:00 AM', 'Hi, Welcome to my thread!'),
  Replies('Daven', 'D', 'LOL', 'Today at 10:03 AM', '+1 rep'),
  Replies('Bings', 'B', 'User', 'Today at 10:09 AM', 'Very good person'),
  Replies('Krishna', 'K', 'User', 'Today at 10:15 AM',
      'What are you hangout recommendations?'),
  Replies('Jingguo', 'J', 'User', 'Today at 10:20 AM',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
  Replies('Christy', 'C', 'LOL', 'Today at 10:25 AM', 'This place kym?')
];
